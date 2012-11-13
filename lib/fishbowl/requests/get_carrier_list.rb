module Fishbowl::Requests
  def self.get_carrier_list
    _, _, response = Fishbowl::Objects::BaseObject.new.send_request('CarrierListRq', 'CarrierListRs')

    results = []
    response.xpath("//Carrier").each do |carrier_xml|
      results << Fishbowl::Objects::Carrier.new(carrier_xml)
    end

    results
  end
end
