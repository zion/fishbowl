require 'spec_helper'

describe Fishbowl::Objects::Country do
  describe "instances" do

    let(:country) {
      doc = Nokogiri::XML.parse(example_file('address.xml'))
      Fishbowl::Objects::Country.new(doc.xpath('//Country'))
    }

    it "should properly initialize from example file" do
      country.name.should eq("United States")
      country.code.should eq("US")
    end
  end
end
