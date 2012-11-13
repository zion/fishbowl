require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_carrier_list" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_carrier_list
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "returns array of carriers" do
      mock_the_response(expected_response)
      response = Fishbowl::Requests.get_carrier_list

      response.should be_an(Array)
      response.first.should be_a(Fishbowl::Objects::Carrier)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.CarrierListRq
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.CarrierListRs(statusCode: '1000', statusMessage: "Success!") {
            xml.Carrier { xml.Name "Will Call" }
            xml.Carrier { xml.Name "UPS" }
            xml.Carrier { xml.Name "FedEx" }
            xml.Carrier { xml.Name "USPS" }
          }
        }
      end
    end
  end
end
