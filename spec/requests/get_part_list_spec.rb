require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_part_list" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    let(:valid_options) {
      #TODO Identify valid options
    }

    it "requires valid options" do
      lambda {
        Fishbowl::Requests.get_part_list(valid_options)
      }.should_not raise_error(ArgumentError)

      valid_options.each do |excluded_key, excluded_value|
        invalid_options = valid_options.keep_if {|k,v| k != excluded_key}

        lambda {
          Fishbowl::Requests.get_part_list(invalid_options)
        }.should raise_error(ArgumentError)
      end
    end

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_part_list(valid_options)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request(options = {})
      options = valid_options.merge(options)

      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetPartListRq {
              #TODO Figure out what goes here!
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.GetPartListRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
