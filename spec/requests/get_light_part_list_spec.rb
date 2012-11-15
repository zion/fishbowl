require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_light_part_list" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_light_part_list
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "returns array of parts" do
      mock_the_response(expected_response)
      response = Fishbowl::Requests.get_light_part_list

      response.should be_an(Array)
      #TODO What else does it return?
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.LightPartListRq
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.LightPartListRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO Mock an array of Accounts
          }
        }
      end
    end
  end
end
