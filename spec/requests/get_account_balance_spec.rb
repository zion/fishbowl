require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_account_balance" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_account_balance("Accounts Payable")
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "returns the balance of the requested account"

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetAccountBalanceRq {
              xml.Account "Accounts Payable"
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.GetAccountBalanceRs(statusCode: '1000', statusMessage: "Success!") {
            xml.Account {
              xml.Name          "Demo Account"
              xml.AccountingID  "DEMO"
              xml.AccountType   9
              xml.Balance       "1200.00"
            }
          }
        }
      end
    end
  end
end
