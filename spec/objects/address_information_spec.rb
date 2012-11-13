require 'spec_helper'

describe Fishbowl::Objects::AddressInformation do
  describe "instances" do

    let(:address_info) {
      doc = Nokogiri::XML.parse(example_file('address.xml'))
      Fishbowl::Objects::AddressInformation.new(doc.xpath('//AddressInformation'))
    }

    it "should properly initialize from example file" do
      address_info.name.should eq("Main Office")
      address_info.data.should eq("Address Data")
      address_info.default.should eq("true")
      address_info.type.should eq("Home")
    end
  end
end
