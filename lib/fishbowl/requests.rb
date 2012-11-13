module Fishbowl; module Requests; end; end

require 'fishbowl/requests/get_carrier_list'

module Fishbowl
  module Requests
    def self.add_inventory(options = {})
      options = options.symbolize_keys

      %w{part_number quantity uom_id cost location_tag_number tag_number}.each do |required_field|
        raise ArgumentError if options[required_field.to_sym].nil?
      end

      raise ArgumentError unless options[:tracking].nil? || options[:tracking].is_a?(Fishbowl::Object::Tracking)

      request = add_inventory_request(options)
      Fishbowl::Objects::BaseObject.new.send_request(request, 'AddInventoryRs')
    end

    def self.add_sales_order_item(options = {})
      options = options.symbolize_keys

      %w{order_number id product_number sales_order_id description taxable
         quantity product_price total_price uom_code item_type status
         quickbooks_class_name new_item_flag}.each do |required_field|
        raise ArgumentError if options[required_field.to_sym].nil?
      end

      request = add_sales_order_item_request(options)
      Fishbowl::Objects::BaseObject.new.send_request(request, 'AddSOItemRs')
    end

    def self.adjust_inventory(options = {})
      options = options.symbolize_keys

      %w{tag_number quantity}.each do |required_field|
        raise ArgumentError if options[required_field.to_sym].nil?
      end

      raise ArgumentError unless options[:tracking].nil? || options[:tracking].is_a?(Fishbowl::Object::Tracking)

      request = adjust_inventory_request(options)
      Fishbowl::Objects::BaseObject.new.send_request(request, 'AdjustInventoryRs')
    end

  private

    def self.add_inventory_request(options)
      Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.AddInventoryRq {
            xml.PartNum options[:part_number]
            xml.Quantity options[:quantity]
            xml.UOMID options[:uom_id]
            xml.Cost options[:cost]
            xml.Note options[:note] unless options[:note].nil?
            xml.Tracking options[:tracking] unless options[:tracking].nil?
            xml.LocationTagNum options[:location_tag_number]
            xml.TagNum options[:tag_number]
          }
        }
      end
    end

    def self.add_sales_order_item_request(options)
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

    def self.adjust_inventory_request(options)
      Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.AdjustInventoryRq {
            xml.TagNum options[:tag_number]
            xml.Quantity options[:quantity]
            xml.Tracking options[:tracking] unless options[:tracking].nil?
          }
        }
      end
    end

  end
end
