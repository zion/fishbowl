require 'spec_helper'

describe Fishbowl::Objects::Country do
  describe "instances" do

    let(:country) {
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.base {
          xml.Country {
            xml.ID
            xml.Code
            xml.Name
          }
        }
      end
      Fishbowl::Objects::Country.new(builder.doc.xpath('//Country'))
    }

    it "should have a db id" do
      country.respond_to?(:db_id).should be_true
    end

    it "should have an name" do
      country.respond_to?(:name).should be_true
    end

    it "should have a code" do
      country.respond_to?(:code).should be_true
    end
  end
end
