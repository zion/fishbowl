module Fishbowl::Objects
  class Account < BaseObject
    def self.get_list
      self.new.send_request("GetAccountListRq")
    end

    def self.get_balance(account)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.GetAccountBalanceRq {
            xml.Account (account.is_a?(Account) ? account.name : account)
          }
        }
      end

      self.new.send_request(builder, true)
    end
  end
end
