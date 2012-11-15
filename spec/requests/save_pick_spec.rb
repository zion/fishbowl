require 'spec_helper'

describe Fishbowl::Requests do
  describe "#save_pick" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }
    let(:mock_pick) {
      #TODO mock a Pick
    }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.save_pick(mock_pick)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.SavePickRq {
              #TODO mock a Pick object
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.SavePickRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
