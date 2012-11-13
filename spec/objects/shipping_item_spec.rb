require 'spec_helper'

describe Fishbowl::Objects::Carton do
  describe "instances" do

    let(:shipping_item) {
      doc = Nokogiri::XML.parse(example_file('carton.xml'))
      Fishbowl::Objects::ShippingItem.new(doc.xpath('//ShippingItem'))
    }

    it "should properly initialize from example file" do
      shipping_item.ship_item_id.should eq("169")
      shipping_item.product_number.should eq("B201")

      shipping_item.uom.should be_a(Fishbowl::Objects::UOM)
      shipping_item.weight_uom.should be_a(Fishbowl::Objects::UOM)
      shipping_item.display_weight_uom.should be_a(Fishbowl::Objects::UOM)
    end
  end
end

