module Fishbowl::Objects
  class Address < BaseObject
    attr_reader :db_id, :temp_account, :name, :attention, :street, :city, :zip
    attr_reader :location_group_id, :default, :residential, :type, :state
    attr_reader :country, :address_information_list

    def initialize(address_xml)
      %w{ID Name Attention Street City Zip LocationGroupID Default Residential Type}.each do |field|
        if field == 'ID'
          instance_var = '@db_id'
        else
          instance_var = '@' + field.gsub(/ID/, 'Id').underscore
        end

        value = address_xml.xpath(field).first.nil? ? nil : address_xml.xpath(field).first.inner_text
        instance_variable_set(instance_var, value)
      end

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

  class State
    attr_reader :db_id, :name, :code, :country_id

    def initialize(state_xml)
      %w{ID Name Code CountryID}.each do |field|
        if field == 'ID'
          instance_var = '@db_id'
        else
          instance_var = '@' + field.gsub(/ID/, 'Id').underscore
        end

        value = state_xml.xpath(field).first.nil? ? nil : state_xml.xpath(field).first.inner_text
        instance_variable_set(instance_var, value)
      end

      self
    end
  end

  class Country
    attr_reader :db_id, :name, :code

    def initialize(country_xml)
      %w{ID Name Code}.each do |field|
        if field == 'ID'
          instance_var = '@db_id'
        else
          instance_var = '@' + field.gsub(/ID/, 'Id').underscore
        end

        value = country_xml.xpath(field).first.nil? ? nil : country_xml.xpath(field).first.inner_text
        instance_variable_set(instance_var, value)
      end

      self
    end
  end

  class AddressInformation
    attr_reader :db_id, :name, :data, :default, :type

    def initialize(address_info_xml)
      %w{ID Name Data Default Type}.each do |field|
        if field == 'ID'
          instance_var = '@db_id'
        else
          instance_var = '@' + field.gsub(/ID/, 'Id').underscore
        end

        value = address_info_xml.xpath(field).first.nil? ? nil : address_info_xml.xpath(field).first.inner_text
        instance_variable_set(instance_var, value)
      end

      self
    end
  end
end
