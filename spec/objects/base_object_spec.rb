require 'spec_helper'

describe Fishbowl::Objects::BaseObject do
  let(:ticket) { "thisisasample" }
  let(:base_object) { Fishbowl::Objects::BaseObject.new }
  let(:connection) { FakeTCPSocket.instance }

  let(:empty_ticket_builder) do
    Nokogiri::XML::Builder.new do |xml|
      xml.FbiXml {
        xml.Ticket

        xml.FbiMsgsRq {
          xml.SampleRq
        }
      }
    end
  end

  let(:ticket_builder) do
    Nokogiri::XML::Builder.new do |xml|
      xml.FbiXml {
        xml.Ticket ticket

        xml.FbiMsgsRq {
          xml.SampleRq
        }
      }
    end
  end

  before :each do
    mock_tcp_connection
    mock_login_response
    Fishbowl::Connection.connect(host: 'localhost')
    Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
  end

  after :each do
    unmock_tcp
  end

  describe "#send_request" do
    before :each do
      mock_the_response
    end

    it "should send the specified request" do
      base_object.send_request("SampleRq", "SampleRs")
      connection.last_write.should be_equivalent_to(empty_ticket_builder.to_xml)
    end

    it "should get the expected response" do
      code, message, response = base_object.send_request("SampleRq", "SampleRs")

      code.should_not be_nil
      message.should_not be_nil
      response.should be_equivalent_to(mock_response.to_xml)
    end
  end

  context "Private Methods" do
    describe "#build_request" do
      it "should build a request document" do
        base_object.send(:build_request, "SampleRq").to_xml.should be_equivalent_to(empty_ticket_builder.to_xml)
      end

      it "should accept an XML Builder" do
        builder = Nokogiri::XML::Builder.new { |xml| xml.request { xml.SampleRq } }
        base_object.send(:build_request, builder).to_xml.should be_equivalent_to(empty_ticket_builder.to_xml)
      end

      context "when ticket is empty" do
        it "should return an empty Nokogiri::XML::Builder" do
          base_object.send(:build_request, "SampleRq").to_xml.should be_equivalent_to(empty_ticket_builder.to_xml)
        end
      end

      context "when ticket is set" do
        before :each do
          base_object.ticket = ticket
        end

        it "should return the ticket wrapped in a Nokogiri::XML::Builder" do
          base_object.send(:build_request, "SampleRq").to_xml.should be_equivalent_to(ticket_builder.to_xml)
        end
      end
    end
  end
end
