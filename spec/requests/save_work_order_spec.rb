require 'spec_helper'

describe Fishbowl::Requests do
  describe "#save_work_order" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }
    let(:mock_work_order) {
      #TODO mock a WorkOrder
    }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.save_work_order(mock_work_order)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.SaveWorkOrderRq {
              #TODO mock a WorkOrder object
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.SaveWorkOrderRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
