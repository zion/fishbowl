require 'spec_helper'

describe Fishbowl::Objects::State do
  describe "instances" do

    let(:state) {
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.base {
          xml.State {
            xml.ID
            xml.Code
            xml.Name
            xml.CountryID
          }
        }
      end
      Fishbowl::Objects::State.new(builder.doc.xpath('//State'))
    }

    it "should have a db id" do
      state.respond_to?(:db_id).should be_true
    end

    it "should have an name" do
      state.respond_to?(:name).should be_true
    end

    it "should have a code" do
      state.respond_to?(:code).should be_true
    end

    it "should have a country id" do
      state.respond_to?(:country_id).should be_true
    end
  end
end
