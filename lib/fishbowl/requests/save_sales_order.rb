module Fishbowl::Requests
  def self.save_sales_order(options)
    # options = options.symbolize_keys
    #
    # %w{number salesman customer_name status
    #    items}.each do |required_field|
    #   raise ArgumentError if options[required_field.to_sym].nil?
    # end

    request = format_sales_order(options)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'SaveSORs')
  end

private

  def self.format_sales_order(sales_order)
    Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.SOSaveRq {
          xml.SalesOrder {
            xml.Number sales_order[:number] unless sales_order[:number].nil?
            xml.Salesman sales_order[:salesman] unless sales_order[:salesman].nil?
            xml.CustomerName sales_order[:customer_name] unless sales_order[:customer_name].nil?
            xml.Status "10"
            xml.Items {
              sales_order[:items].each do |item|
                xml.SalesOrderItem {
                  xml.ID item[:id] unless item[:id].nil?
                  xml.ProductNumber item[:product_number] unless item[:product_number].nil?
                  xml.ProductPrice item[:product_price] unless item[:product_price].nil?
                  xml.Quantity item[:quantity] unless item[:quantity].nil?
                  xml.UOMCode item[:uom_code] unless item[:uom_code].nil?
                  xml.Description item[:description] unless item[:description].nil?
                  xml.LineNumber item[:line_number] unless item[:line_number].nil?
                  xml.NewItemFlag "false"
                  xml.ItemType "10"
                  xml.Status "10"
                }
              end
            }
          }
          xml.IssueFlag "false"
          xml.IgnoreItems "false"
        }
      }
    end

  end

end
