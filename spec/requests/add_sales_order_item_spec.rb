require 'spec_helper'

describe Fishbowl::Requests do
  describe "#add_sales_order_item" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    let(:valid_options) {
      {
        order_number:           1,
        id:                     -1,
        product_number:         'BTY100-Core',
        sales_order_id:         94,
        description:            'Battery Pack',
        taxable:                true,
        quantity:               1,
        product_price:          95.00,
        total_price:            95.00,
        uom_code:               'ea',
        item_type:              20,
        status:                 10,
        quickbooks_class_name:  'Salt Lake City',
        new_item_flag:          false
      }
    }

    it "requires valid options" do
      lambda {
        Fishbowl::Requests.add_sales_order_item(valid_options)
      }.should_not raise_error(ArgumentError)

      valid_options.each do |excluded_key, excluded_value|
        invalid_options = valid_options.keep_if {|k,v| k != excluded_key}

        lambda {
          Fishbowl::Requests.add_sales_order_item(invalid_options)
        }.should raise_error(ArgumentError)
      end
    end

    it "sends proper request" do
      mock_the_response('AddSOItemRs')
      Fishbowl::Requests.add_sales_order_item(valid_options)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request(options = {})
      options = valid_options.merge(options)

      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.AddSOItemRq {
              xml.OrderNum options[:order_number]
              xml.SalesOrderItem {
                xml.ID options[:id]
                xml.ProductNumber options[:product_number]
                xml.SOID options[:sales_order_id]
                xml.Description options[:description]
                xml.Taxable options[:taxable]
                xml.Quantity options[:quantity]
                xml.ProductPrice options[:product_price]
                xml.TotalPrice options[:total_price]
                xml.UOMCode options[:uom_code]
                xml.ItemType options[:item_type]
                xml.Status options[:status]
                xml.QuickBooksClassName options[:quickbooks_class_name]
                xml.NewItemFlag options[:new_item_flag]
              }
            }
          }
        }
      end

      request.to_xml
    end
  end
end
