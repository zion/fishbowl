require 'spec_helper'

describe Fishbowl::Objects::Account do
  before :each do
    mock_tcp_connection
    Fishbowl::Connection.connect(host: 'localhost')
    Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
  end

  after :each do
    unmock_tcp
  end

  let(:connection) { FakeTCPSocket.instance }

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

    let(:canned_response) do

    end

    it "should properly format the request" do
      Fishbowl::Objects::Account.get_list

      connection.last_write.should eq(proper_request.to_xml)
    end

    it "should return array of Accounts"

    it "should return empty array when no accounts" do

    end
  end

  describe ".get_balance" do
    it "should properly format the request"

    it "should return the balance for the requested Account"
  end
end
