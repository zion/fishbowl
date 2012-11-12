require 'spec_helper'

describe Fishbowl::Objects::AddressInformation do
  describe "instances" do

    let(:address_info) {
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.base {
          xml.AddressInformation {
            xml.ID
            xml.Name
            xml.Data
            xml.Default
            xml.Type
          }
        }
      end
      Fishbowl::Objects::AddressInformation.new(builder.doc.xpath('//AddressInformation'))
    }

    it "should have a db id" do
      address_info.respond_to?(:db_id).should be_true
    end

    it "should have an name" do
      address_info.respond_to?(:name).should be_true
    end

    it "should have a data" do
      address_info.respond_to?(:data).should be_true
    end

    it "should have a default" do
      address_info.respond_to?(:default).should be_true
    end

    it "should have a type" do
      address_info.respond_to?(:type).should be_true
    end
  end
end
