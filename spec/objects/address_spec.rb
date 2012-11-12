require 'spec_helper'

describe Fishbowl::Objects::Address do
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

    let(:address) {
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.base {
          xml.Address {
            xml.ID
            xml.send('Temp-Account') {
              xml.ID
              xml.Type
            }
            xml.Name
            xml.Attn
            xml.Street
            xml.City
            xml.Zip
            xml.LocationGroupID
            xml.Default
            xml.Residential
            xml.Type
            xml.State {
              xml.ID
              xml.Code
              xml.Name
              xml.CountryID
            }
            xml.Country {
              xml.ID
              xml.Name
              xml.Code
            }
            xml.AddressInformationList {
              xml.AddressInformation {
                xml.ID
                xml.Name
                xml.Data
                xml.Default
                xml.Type
              }
            }
          }
        }
      end
      Fishbowl::Objects::Address.new(builder.doc.xpath('//Address'))
    }

    it "should have a db id" do
      address.respond_to?(:db_id).should be_true
    end

    it "should have a temp account" do
      address.respond_to?(:temp_account).should be_true
    end

    it "should have a name" do
      address.respond_to?(:name).should be_true
    end

    it "should have an attention" do
      address.respond_to?(:attention).should be_true
    end

    it "should have a street" do
      address.respond_to?(:street).should be_true
    end

    it "should have a city" do
      address.respond_to?(:city).should be_true
    end

    it "should have a state" do
      address.respond_to?(:state).should be_true
    end

    it "should have a zip" do
      address.respond_to?(:zip).should be_true
    end

    it "should have a country" do
      address.respond_to?(:country).should be_true
    end

    it "should have a location group id" do
      address.respond_to?(:location_group_id).should be_true
    end

    it "should have a default" do
      address.respond_to?(:default).should be_true
    end

    it "should have a residential" do
      address.respond_to?(:residential).should be_true
    end

    it "should have a type" do
      address.respond_to?(:type).should be_true
    end

    it "should have a address information list" do
      address.respond_to?(:address_information_list).should be_true
    end
  end
end

