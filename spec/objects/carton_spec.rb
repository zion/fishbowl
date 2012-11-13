require 'spec_helper'

describe Fishbowl::Objects::Carton do
  describe "instances" do

    let(:carton) {
      doc = Nokogiri::XML.parse(example_file('carton.xml'))
      Fishbowl::Objects::Carton.new(doc.xpath('//Carton'))
    }

    it "should properly initialize from example file" do
      carton.db_id.should eq("64")
      carton.ship_id.should eq("63")
      carton.carton_num.should eq("1")
      carton.tracking_num.should be_empty
      carton.freight_weight.should eq("1.2")
      carton.freight_amount.should eq("0")

      carton.shipping_items.first.should be_a(Fishbowl::Objects::ShippingItem)
    end
  end
end

