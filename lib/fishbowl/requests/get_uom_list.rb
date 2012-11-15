module Fishbowl::Requests
  def self.get_uom_list
    _, _, response = Fishbowl::Objects::BaseObject.new.send_request('UOMRq', 'UOMRs')

    results = []
    response.xpath("//UOM").each do |uom_xml|
      results << Fishbowl::Objects::UOM.new(uom_xml)
    end

    results
  end
end
