module Fishbowl::Objects
  class Account < BaseObject
    attr_reader :name, :accounting_id, :account_type, :balance

    def self.attributes
      %w{Name AccountingID AccountType Balance}
    end

    def initialize(account_xml)
      @xml = account_xml
      parse_attributes
      self
    end

    def self.get_list
      _, _, response = BaseObject.new.send_request("GetAccountListRq", "GetAccountListRs")

      results = []

      response.xpath("//Account").each do |account_xml|
        results << Account.new(account_xml)
      end

      results
    end
  end
end
