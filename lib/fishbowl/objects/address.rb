module Fishbowl::Objects
  class Address < BaseObject
    attr_reader :db_id, :temp_account, :name, :attn, :street, :city, :zip
    attr_reader :location_group_id, :default, :residential, :type, :state
    attr_reader :country, :address_information_list

    def self.attributes
      %w{ID Name Attn Street City Zip LocationGroupID Default Residential Type}
    end

    def initialize(address_xml)
      @xml = address_xml
      parse_attributes

      @temp_account
      @state = get_state(address_xml)
      @country = get_country(address_xml)
      @address_information_list = get_address_information(address_xml)

      self
    end

  private

    def get_state(address_xml)
      State.new(address_xml.xpath("State"))
    end

    def get_country(address_xml)
      Country.new(address_xml.xpath("Country"))
    end

    def get_address_information(address_xml)
      results = []

      address_xml.xpath("AddressInformationList").each do |address_info_xml|
        results << AddressInformation.new(address_info_xml)
      end

      results
    end

  end

  class State < BaseObject
    attr_reader :db_id, :name, :code, :country_id

    def self.attributes
      %w{ID Name Code CountryID}
    end

    def initialize(state_xml)
      @xml = state_xml
      parse_attributes
      self
    end
  end

  class Country < BaseObject
    attr_reader :db_id, :name, :code

    def self.attributes
      %w{ID Name Code}
    end

    def initialize(country_xml)
      @xml = country_xml
      parse_attributes
      self
    end
  end

  class AddressInformation < BaseObject
    attr_reader :db_id, :name, :data, :default, :type

    def self.attributes
      %w{ID Name Data Default Type}
    end

    def initialize(address_info_xml)
      @xml = address_info_xml
      parse_attributes
      self
    end
  end
end
