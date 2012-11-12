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
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.base {
          xml.Account {
            xml.Name          "Demo Account"
            xml.AccountingID  "DEMO"
            xml.AccountType   1
            xml.Balance       "1200.00"
          }
        }
      end
      Fishbowl::Objects::Account.new(builder.doc.xpath('//Account'))
    }

    it "should have a name" do
      account.respond_to?(:name).should be_true
    end

    it "should have an accounting id" do
      account.respond_to?(:accounting_id).should be_true
    end

    it "should have a type" do
      account.respond_to?(:type).should be_true
    end

    it "should have a balance" do
      account.respond_to?(:balance).should be_true
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
