require 'spec_helper'

describe Fishbowl::Objects::Account do
  before :each do
    mock_tcp_connection
    mock_login_response
    Fishbowl::Connection.connect(host: 'localhost')
    Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
  end

  after :each do
    unmock_tcp
  end

  let(:connection) { FakeTCPSocket.instance }

  describe "instances" do

    let(:account) {
      doc = Nokogiri::XML.parse(example_file('account.xml'))
      Fishbowl::Objects::Account.new(doc.xpath('//Account'))
    }

    it "should properly initialize from example file" do
      account.name.should eq("Cost Variance")
      account.accounting_id.should eq("8000001B-1310422643")
      account.account_type.should eq("12")
      account.balance.should eq("0")
    end
  end

  describe ".get_list" do
    let(:proper_request) do
      Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetAccountListRq
          }
        }
      end
    end

    before :each do
      canned_response = Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.GetAccountListRs(statusCode: '1000', statusMessage: "Success!") {
            (rand(3) + 2).times do |i|
              xml.Account {
                xml.Name          "Demo Account #{i}"
                xml.AccountingID  "DEMO#{i}"
                xml.AccountType   i
                xml.Balance       "1200.00"
              }
            end
          }
        }
      end

      mock_the_response(canned_response)
    end

    it "should properly format the request" do
      Fishbowl::Objects::Account.get_list
      connection.last_write.should be_equivalent_to(proper_request.to_xml)
    end

    it "should return array of Accounts" do
      Fishbowl::Objects::Account.get_list.should be_an(Array)
    end
  end

  describe ".get_balance" do
    let(:proper_request) do
      Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetAccountBalanceRq {
              xml.Account "General Account"
            }
          }
        }
      end
    end

    before :each do
      canned_response = Nokogiri::XML::Builder.new do |xml|
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

      mock_the_response(canned_response)
    end

    it "should properly format the request" do
      Fishbowl::Objects::Account.get_balance("General Account")
      connection.last_write.should be_equivalent_to(proper_request.to_xml)
    end

    it "should return the balance for the requested Account" do
      Fishbowl::Objects::Account.get_balance("General Account").should be_a(String)
    end
  end
end
