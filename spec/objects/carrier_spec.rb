require 'spec_helper'

describe Fishbowl::Objects::Carrier do
  describe "instances" do

    let(:carrier) {
      doc = Nokogiri::XML.parse(example_file('carrier.xml'))
      Fishbowl::Objects::Carrier.new(doc.xpath('//Carrier'))
    }

    it "should properly initialize from example file" do
      carrier.name.should eq("Will Call")
    end
  end
end
