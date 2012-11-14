module Fishbowl::Requests
  def self.get_account_list
    _, _, response = Fishbowl::Objects::BaseObject.new.send_request('GetAccountListRq', 'GetAccountListRs')

    results = []

    response.xpath("//Account").each do |account_xml|
      results << Account.new(account_xml)
    end

    results
  end
end
