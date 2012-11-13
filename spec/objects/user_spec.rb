require 'spec_helper'

describe Fishbowl::Objects::User do
  describe "instances" do

    let(:user) {
      doc = Nokogiri::XML.parse(example_file('user.xml'))
      Fishbowl::Objects::User.new(doc.xpath('//User'))
    }

    it "should properly initialize from example file" do
      user.db_id.should eq("1")
      user.user_name.should eq("admin")
      user.first_name.should eq("Administrator")
      user.last_name.should eq("Administrator")
      user.initials.should eq("ADM")
      user.active.should eq("true")
    end
  end
end
