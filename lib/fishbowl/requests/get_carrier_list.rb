module Fishbowl::Requests
  def self.get_carrier_list
    puts "getting carriers"
    code, response = Fishbowl::Objects::BaseObject.new.send_request('CarrierListRq', 'FbiMsgsRs/CarrierListRs')
    
    binding.pry
    results = []

    response.xpath("//Carriers/Name").each do |carrier_xml|
      results << Fishbowl::Objects::Carrier.new(carrier_xml)
    end

    results
  end
end
