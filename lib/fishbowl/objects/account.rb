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

    def self.get_balance(account)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.GetAccountBalanceRq {
            xml.Account (account.is_a?(Account) ? account.name : account)
          }
        }
      end

      _, _, response = BaseObject.new.send_request(builder, "GetAccountBalanceRs")

      response.xpath("//Account/Balance").first.inner_text
    end
  end
end
