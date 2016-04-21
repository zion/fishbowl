module Fishbowl::Requests
  def self.total_inventory(part_num, location_group)
    raise ArgumentError if part_num.nil?

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.GetTotalInventoryRq {
          xml.PartNumber part_num
          xml.LocationGroup location_group
        }
      }
    end

    code, response = Fishbowl::Objects::BaseObject.new.send_request(builder, "GetTotalInventoryRs")

    response.xpath("//FbiXml/FbiMsgsRs/GetTotalInventoryRs")
  end
end
