module Fishbowl
  module Requests
    def self.add_inventory(options = {})
      options = options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      raise ArgumentError if options[:part_number].nil?
      raise ArgumentError if options[:quantity].nil?
      raise ArgumentError if options[:uom_id].nil?
      raise ArgumentError if options[:cost].nil?
      raise ArgumentError if options[:location_tag_number].nil?
      raise ArgumentError if options[:tag_number].nil?

      raise ArgumentError unless options[:tracking].nil? || options[:tracking].is_a?(Fishbowl::Object::Tracking)

      request = Nokogiri::XML::Builder.new do |xml|
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

      Fishbowl::Objects::BaseObject.new.send_request(request, 'AddInventoryRs')
    end
  end
end
