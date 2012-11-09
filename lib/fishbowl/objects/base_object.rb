module Fishbowl::Objects
  class BaseObject
    attr_accessor :ticket

    def send_request(request)
      Fishbowl::Connection.send(build_request(request))
    end

  private

    def build_request(request, fragment = false)
      Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          if @ticket.nil?
            xml.Ticket
          else
            xml.Ticket @ticket
          end

          xml.FbiMsgsRq {
            xml << request.doc.xpath("request/*").to_xml if fragment
            xml.send(request.to_s) unless fragment
          }
        }
      end
    end

  end
end
