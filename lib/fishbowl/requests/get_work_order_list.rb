module Fishbowl::Requests
  def self.get_work_order_list
    _, _, response = Fishbowl::Objects::BaseObject.new.send_request('WorkOrderListRq', 'WorkOrderListRs')

    results = []
    response.xpath("//WO").each do |work_order_xml|
      results << Fishbowl::Objects::WorkOrder.new(work_order_xml)
    end

    results
  end
end
