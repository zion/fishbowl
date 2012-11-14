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
  end
end
