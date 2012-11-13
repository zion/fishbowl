require 'spec_helper'

describe Fishbowl::Objects::UOM do
  describe "instances" do

    let(:uom) {
      doc = Nokogiri::XML.parse(example_file('uom.xml'))
      Fishbowl::Objects::UOM.new(doc.xpath('//UOM'))
    }

    it "should properly initialize from example file" do
      uom.uomid.should eq("1")
      uom.name.should eq("Each")
      uom.code.should eq("ea")

      uom.uom_conversions.should be_a(Array)
      uom.uom_conversions.first.should be_a(Fishbowl::Objects::UOMConversion)
    end
  end
end
