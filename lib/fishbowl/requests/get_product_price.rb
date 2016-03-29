module Fishbowl::Requests
  def self.get_product_price(options)
    options.symbolize_keys

    %w{product_number customer_name qauntity date}.each do |required_field|
        raise ArgumentError if options[required_field.to_sym].nil?
      end

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.ProductPriceRq {
          xml.ProductNumber
        }
      }
    end

    _, _, response = Fishbowl::Objects::BaseObject.new.send_request(builder, "GetAccountBalanceRs")

    response.xpath("//Account/Balance").first.inner_text
  end
end
