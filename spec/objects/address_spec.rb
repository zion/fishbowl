require 'spec_helper'

describe Fishbowl::Objects::Address do
  before :each do
    mock_tcp_connection
    mock_login_response
    Fishbowl::Connection.connect(host: 'localhost')
    Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
  end

  after :each do
    unmock_tcp
  end

  let(:connection) { FakeTCPSocket.instance }

  describe "instances" do

    let(:address) {
      doc = Nokogiri::XML.parse(example_file('address.xml'))
      Fishbowl::Objects::Address.new(doc.xpath('//Address'))
    }

    it "should properly initialize from example file" do
      address.name.should eq("Main Office")
      address.attn.should eq("Attn")
      address.street.should eq("123 Neverland dr.")

      address.state.should be_a(Fishbowl::Objects::State)
      address.country.should be_a(Fishbowl::Objects::Country)
      address.address_information_list.should be_a(Array)
      address.address_information_list.first.should be_a(Fishbowl::Objects::AddressInformation)
    end
  end
end

