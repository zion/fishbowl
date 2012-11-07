require 'spec_helper'

describe Fishbowl::Objects::BaseObject do
  let(:ticket) { "thisisasample" }
  let(:base_object) { Fishbowl::Objects::BaseObject.new }

  let(:empty_ticket_builder) do
    Nokogiri::XML::Builder.new do |xml|
      xml.FbiXml {
        xml.Ticket

        xml.FbiMsgsRq {
          xml.SampleRequest
        }
      }
    end
  end

  let(:ticket_builder) do
    Nokogiri::XML::Builder.new do |xml|
      xml.FbiXml {
        xml.Ticket ticket

        xml.FbiMsgsRq {
          xml.SampleRequest
        }
      }
    end
  end

  context "Protected Methods" do
    describe "#send_request" do

    end
  end

  context "Private Methods" do
    describe "#build_request" do
      it "should build a request document" do
        base_object.send(:build_request, "SampleRequest").to_xml.should eq(empty_ticket_builder.to_xml)
      end

      context "when ticket is empty" do
        it "should return an empty Nokogiri::XML::Builder" do
          base_object.send(:build_request, "SampleRequest").to_xml.should eq(empty_ticket_builder.to_xml)
        end
      end

      context "when ticket is set" do
        before :each do
          base_object.ticket = ticket
        end

        it "should return the ticket wrapped in a Nokogiri::XML::Builder" do
          base_object.send(:build_request, "SampleRequest").to_xml.should eq(ticket_builder.to_xml)
        end
      end
    end
  end
end
