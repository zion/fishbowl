module Fishbowl::Requests
  def self.get_customer_list
    _, _, response = Fishbowl::Objects::BaseObject.new.send_request('CustomerListRq', 'CustomerListRs')

    results = []
    response.xpath("//Customer").each do |customer_xml|
      results << Fishbowl::Objects::Customer.new(customer_xml)
    end

    results
  end
end
