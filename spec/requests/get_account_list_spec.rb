require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_account_list" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_account_list
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "returns array of accounts" do
      mock_the_response(expected_response)
      response = Fishbowl::Requests.get_account_list

      response.should be_an(Array)
      response.first.should be_a(Fishbowl::Objects::Account)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetAccountListRq
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.GetAccountListRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO Mock an array of Accounts
          }
        }
      end
    end
  end
end
