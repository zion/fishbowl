require 'spec_helper'

describe Fishbowl::Objects::State do
  describe "instances" do

    let(:state) {
      doc = Nokogiri::XML.parse(example_file('address.xml'))
      Fishbowl::Objects::State.new(doc.xpath('//State'))
    }

    it "should properly initialize from example file" do
      state.name.should eq("Utah")
      state.code.should eq("UT")
      state.country_id.should eq("2")
    end
  end
end
