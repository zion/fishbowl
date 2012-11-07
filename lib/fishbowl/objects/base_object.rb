module Fishbowl::Objects
  class BaseObject
    attr_accessor :ticket

  protected

    def send_request(request)
      Fishbowl::Connection.send(build_request(request))
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
            xml.send(request)
          }
        }
      end
    end

  end
end
