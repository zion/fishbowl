module Fishbowl::Requests
  def self.void_sales_order(number)
    request = format_add_sales_order_item_request(number.to_s)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'VoidSORs')
  end

private

  def self.format_add_sales_order_item_request(number)
    Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.VoidSORq {
          xml.SONumber number
        }
      }
    end
  end
end
