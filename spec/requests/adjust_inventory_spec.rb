require 'spec_helper'

describe Fishbowl::Requests do
  describe "#adjust_inventory" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    let(:valid_options) {
      {
        tag_number: 1,
        quantity:   5
      }
    }

    it "requires valid options" do
      lambda {
        Fishbowl::Requests.adjust_inventory(valid_options)
      }.should_not raise_error(ArgumentError)

      valid_options.each do |excluded_key, excluded_value|
        invalid_options = valid_options.keep_if {|k,v| k != excluded_key}

        lambda {
          Fishbowl::Requests.adjust_inventory(invalid_options)
        }.should raise_error(ArgumentError)
      end
    end

    it "sends proper request" do
      mock_the_response('AdjustInventoryRs')
      Fishbowl::Requests.adjust_inventory(valid_options)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "includes tracking when provided"

    def expected_request(options = {})
      options = valid_options.merge(options)

      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.AdjustInventoryRq {
              xml.TagNum valid_options[:tag_number]
              xml.Quantity valid_options[:quantity]
              xml.Tracking options[:tracking] unless options[:tracking].nil?
            }
          }
        }
      end

      request.to_xml
    end
  end
end
