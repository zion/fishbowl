module Fishbowl::Requests
  def self.get_location_list
    _, _, response = Fishbowl::Objects::BaseObject.new.send_request('LocationListRq', 'LocationListRs')

    results = []
    #response.xpath("//Customer/Name").each do |customer_xml|
    #  results << customer_xml.inner_text
    #end

    results
  end
end
