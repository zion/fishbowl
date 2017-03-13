module Fishbowl::Requests
  def self.load_sales_order(order_number)
    raise Fishbowl::Errors.ArgumentError if order_number.nil?
    request = load_order_request(order_number)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'SaveSORs')
  end

private

  def self.load_order_request(order_number)
    Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.LoadSORq {
          xml.Number order_number.to_s
        }
      }
    end

  end

end
