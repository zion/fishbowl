require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_product_information" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_product_information("B200", true)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request(options = {})
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.ProductGetRq {
              xml.Number "B200"
              xml.GetImage true
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.ProductGetRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
