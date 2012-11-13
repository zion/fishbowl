module Fishbowl::Objects
  class UOM < BaseObject
    attr_accessor :uomid, :name, :code, :integral, :active, :type
    attr_accessor :uom_conversions

    def self.attributes
      %w{UOMID Name Code Integral Active Type}
    end

    def initialize(uom_xml)
      @xml = uom_xml
      parse_attributes

      @uom_conversions = get_uom_conversions

      self
    end

  private

    def get_uom_conversions
      results = []

      @xml.xpath("//UOMConversions/UOMConversion").each do |xml|
        results << Fishbowl::Objects::UOMConversion.new(xml)
      end

      results
    end

  end

  class UOMConversion < BaseObject
    attr_accessor :main_uom_id, :to_uom_id, :to_uom_code, :conversion_multiply
    attr_accessor :conversion_factor, :to_uom_is_integral

    def self.attributes
      %w{MainUOMID ToUOMID ToUOMCode ConversionMultiply ConversionFactor ToUOMIsIntegral}
    end

    def initialize(uom_conversion_xml)
      @xml = uom_conversion_xml
      parse_attributes
      self
    end
  end
end
