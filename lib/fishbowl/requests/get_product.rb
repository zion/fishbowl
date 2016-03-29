module Fishbowl::Requests
  def self.get_product(product_number)
    raise ArgumentError if product_number.nil?

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.ProductGetRq {
          xml.Number product_number
          xml.GetImage false
        }
      }
    end

    code, response = Fishbowl::Objects::BaseObject.new.send_request(builder, "ProductGetRs")

    response.xpath("//FbiXml/FbiMsgsRs/ProductGetRs/Product")
  end
end
