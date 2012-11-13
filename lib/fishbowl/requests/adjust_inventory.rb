module Fishbowl::Requests
  def self.adjust_inventory(options = {})
    options = options.symbolize_keys

    %w{tag_number quantity}.each do |required_field|
      raise ArgumentError if options[required_field.to_sym].nil?
    end

    raise ArgumentError unless options[:tracking].nil? || options[:tracking].is_a?(Fishbowl::Object::Tracking)

    request = format_adjust_inventory_request(options)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'AdjustInventoryRs')
  end

private

  def self.format_adjust_inventory_request(options)
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
