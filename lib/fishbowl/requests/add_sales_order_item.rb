module Fishbowl::Requests
  def self.add_sales_order_item(options = {})
    options = options.symbolize_keys

    %w{order_number id product_number sales_order_id description taxable
       quantity product_price total_price uom_code item_type status
       quickbooks_class_name new_item_flag}.each do |required_field|
      raise ArgumentError if options[required_field.to_sym].nil?
    end

    request = format_add_sales_order_item_request(options)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'AddSOItemRs')
  end

private

  def self.format_add_sales_order_item_request(options)
    Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.AddSOItemRq {
          xml.OrderNum options[:order_number]
          xml.SalesOrderItem {
            xml.ID options[:id]
            xml.ProductNumber options[:product_number]
            xml.SOID options[:sales_order_id]
            xml.Description options[:description]
            xml.Taxable options[:taxable]
            xml.Quantity options[:quantity]
            xml.ProductPrice options[:product_price]
            xml.TotalPrice options[:total_price]
            xml.UOMCode options[:uom_code]
            xml.ItemType options[:item_type]
            xml.Status options[:status]
            xml.QuickBooksClassName options[:quickbooks_class_name]
            xml.NewItemFlag options[:new_item_flag]
          }
        }
      }
    end
  end

end
