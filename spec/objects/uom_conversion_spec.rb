require 'spec_helper'

describe Fishbowl::Objects::UOMConversion do
  describe "instances" do

    let(:uom_conversion) {
      doc = Nokogiri::XML.parse(example_file('uom_conversion.xml'))
      Fishbowl::Objects::UOMConversion.new(doc.xpath('//UOMConversion'))
    }

    it "should properly initialize from example file" do
      uom_conversion.main_uom_id.should eq("1")
      uom_conversion.to_uom_id.should eq("17")
      uom_conversion.to_uom_code.should eq("pr")
      uom_conversion.conversion_multiply.should eq("1.0")
      uom_conversion.conversion_factor.should eq("2.0")
      uom_conversion.to_uom_is_integral.should eq("false")
    end
  end
end
