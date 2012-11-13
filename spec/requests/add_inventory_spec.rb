require 'spec_helper'

describe Fishbowl::Requests do
  describe "#add_inventory" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    let(:valid_options) {
      {
        part_number:          "B103",
        quantity:             6,
        uom_id:               1,
        cost:                 33.01,
        location_tag_number:  1,
        tag_number:           1
      }
    }

    it "requires valid options" do
      lambda {
        Fishbowl::Requests.add_inventory(valid_options)
      }.should_not raise_error(ArgumentError)

      valid_options.each do |excluded_key, excluded_value|
        invalid_options = valid_options.keep_if {|k,v| k != excluded_key}

        lambda {
          Fishbowl::Requests.add_inventory(invalid_options)
        }.should raise_error(ArgumentError)
      end
    end

    it "sends proper request" do
      mock_the_response('AddInventoryRs')
      Fishbowl::Requests.add_inventory(valid_options)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "includes note option when supplied" do
      additional_options = { note: 'This is a test' }

      mock_the_response('AddInventoryRs')
      Fishbowl::Requests.add_inventory(valid_options.merge(additional_options))
      connection.last_write.should be_equivalent_to(expected_request(additional_options))
    end

    it "includes tracking option when supplied"

    def expected_request(options = {})
      options = valid_options.merge(options)

      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.AddInventoryRq {
              xml.PartNum options[:part_number]
              xml.Quantity options[:quantity]
              xml.UOMID options[:uom_id]
              xml.Cost options[:cost]
              xml.Note options[:note] unless options[:note].nil?
              xml.Tracking options[:tracking] unless options[:tracking].nil?
              xml.LocationTagNum valid_options[:location_tag_number]
              xml.TagNum valid_options[:tag_number]
            }
          }
        }
      end

      request.to_xml
    end
  end
end
