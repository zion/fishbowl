module Fishbowl::Requests
  def self.add_inventory(options = {})
    options = options.symbolize_keys

    %w{part_number quantity uom_id cost location_tag_number tag_number}.each do |required_field|
      raise ArgumentError if options[required_field.to_sym].nil?
    end

    raise ArgumentError unless options[:tracking].nil? || options[:tracking].is_a?(Fishbowl::Object::Tracking)

    request = format_add_inventory_request(options)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'AddInventoryRs')
  end

private

  def self.format_add_inventory_request(options)
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

end
