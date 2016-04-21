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
            xml.Status "10" if sales_order[:status].nil?
            xml.Status sales_order[:status] unless sales_order[:status].nil?
            xml.PaymentTerms sales_order[:payment_terms] unless sales_order[:payment_terms].nil?
            xml.CustomerPO sales_order[:customer_po] unless sales_order[:customer_po].nil?
            xml.VendorPO sales_order[:vendor_po] unless sales_order[:vendor_po].nil?
            xml.BillTo {
              xml.Name sales_order[:bill_to][:name] unless sales_order[:bill_to][:name].nil?
              xml.AddressField sales_order[:bill_to][:address] unless sales_order[:bill_to][:address].nil?
              xml.City sales_order[:bill_to][:city] unless sales_order[:bill_to][:city].nil?
              xml.Zip sales_order[:bill_to][:zip] unless sales_order[:bill_to][:zip].nil?
              xml.Country sales_order[:bill_to][:country] unless sales_order[:bill_to][:country].nil?
              xml.State sales_order[:bill_to][:state] unless sales_order[:bill_to][:state].nil?
            }
            xml.Ship {
              xml.Name sales_order[:ship_to][:name] unless sales_order[:ship_to][:name].nil?
              xml.AddressField sales_order[:ship_to][:address] unless sales_order[:ship_to][:address].nil?
              xml.City sales_order[:ship_to][:city] unless sales_order[:ship_to][:city].nil?
              xml.Zip sales_order[:ship_to][:zip] unless sales_order[:ship_to][:zip].nil?
              xml.Country sales_order[:ship_to][:country] unless sales_order[:ship_to][:country].nil?
              xml.State sales_order[:ship_to][:state] unless sales_order[:ship_to][:state].nil?
            }
            xml.CustomFields {
              sales_order[:custom_fields].each do |field|
                xml.CustomField {
                  xml.ID field[:id] unless field[:id].nil?
                  xml.Name field[:name] unless field[:name].nil?
                  xml.Type field[:type] unless field[:type].nil?
                  xml.Info field[:info] unless field[:info].nil?
                  xml.Description field[:description] unless field[:description].nil?
                }
              end
            } unless sales_order[:custom_fields].nil?
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
                } unless sales_order[:items].nil?
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
