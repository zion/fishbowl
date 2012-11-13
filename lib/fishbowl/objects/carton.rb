module Fishbowl::Objects
  class Carton < BaseObject
    attr_reader :db_id, :ship_id, :carton_num, :tracking_num, :freight_weight, :freight_amount, :shipping_items

    def self.attributes
      %w{ID ShipID CartonNum TrackingNum FreightWeight FreightAmount}
    end

    def initialize(carton_xml)
      @xml = carton_xml
      parse_attributes

      @shipping_items = get_shipping_items

      self
    end

  private

    def get_shipping_items
      results = []

      @xml.xpath('ShippingItems/ShippingItem').each do |xml|
        results << Fishbowl::Objects::ShippingItem.new(xml)
      end

      results
    end
  end

  class ShippingItem < BaseObject
    attr_reader :ship_item_id, :product_number, :product_description
    attr_reader :qty_shipped, :cost, :sku, :upc, :order_item_id
    attr_reader :order_line_item, :carton_name, :carton_id, :tag_num, :weight
    attr_reader :display_weight, :tracking, :uom, :weight_uom, :display_weight_uom

    def self.attributes
      %w{ShipItemID ProductNumber ProductDescription QtyShipped Cost SKU UPC
         OrderItemID OrderLineItem CartonName CartonID TagNum Weight
         DisplayWeight Tracking}
    end

    def initialize(shipping_item_xml)
      @xml = shipping_item_xml
      parse_attributes

      @uom = Fishbowl::Objects::UOM.new(@xml.xpath("UOM"))
      @weight_uom = Fishbowl::Objects::UOM.new(@xml.xpath("WeightUOM/UOM"))
      @display_weight_uom = Fishbowl::Objects::UOM.new(@xml.xpath("DisplayWeightUOM/UOM"))

      self
    end
  end
end
