module Fishbowl::Objects
  class Carrier < BaseObject
    attr_accessor :name

    def self.attributes
      %w{Name}
    end

    def initialize(carrier_xml)
      @xml = carrier_xml
      parse_attributes
      self
    end
  end
end
