module Fishbowl::Requests
  def self.inventory_quantity(part_num)
    raise ArgumentError if part_num.nil?

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.InvQtyRq {
          xml.PartNum part_num
        }
      }
    end

    code, response = Fishbowl::Objects::BaseObject.new.send_request(builder, "InvQtyRs")

    response.xpath("//FbiXml/FbiMsgsRs/InvQtyRs")
  end
end
