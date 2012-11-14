module Fishbowl::Requests
  def self.get_account_balance(account_name)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.GetAccountBalanceRq {
          xml.Account (account.is_a?(Account) ? account.name : account)
        }
      }
    end

    _, _, response = Fishbowl::Objects::BaseObject.new.send_request(builder, "GetAccountBalanceRs")

    response.xpath("//Account/Balance").first.inner_text
  end
end
