module Fishbowl::Objects
  class BaseObject
    attr_accessor :ticket

    def send_request(request, expected_response = 'FbiMsgRs')
      code, message, response = Fishbowl::Connection.send(build_request(request), expected_response)
      Fishbowl::Errors.confirm_success_or_raise(code, message)
      [code, message, response]
    end

  private

    def build_request(request)
      Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          if @ticket.nil?
            xml.Ticket
          else
            xml.Ticket @ticket
          end

          xml.FbiMsgsRq {
            if request.respond_to?(:to_xml)
              xml << request.doc.xpath("request/*").to_xml
            else
              xml.send(request.to_s)
            end
          }
        }
      end
    end

  end
end
