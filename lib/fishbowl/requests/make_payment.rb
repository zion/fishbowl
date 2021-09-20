module Fishbowl::Requests
  def self.make_payment(options)
    # options = options.symbolize_keys
    #
    %w{amount so_number payment_method}.each do |required_field|
      raise ArgumentError if options[required_field.to_sym].nil?
    end

    request = format_payment(options)
    Fishbowl::Objects::BaseObject.new.send_request(request, 'MakePaymentRs')
  end

private

  def self.format_payment(payment)
    Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.MakePaymentRq {
          xml.Payment {
            xml.Amount payment[:amount] unless payment[:amount].nil?
            xml.SalesOrderNumber payment[:so_number] unless payment[:so_number].nil?
            xml.PaymentDate payment[:payment_date] unless payment[:payment_date].nil?
            xml.PaymentMethod payment[:payment_method] unless payment[:payment_method].nil?
            xml.TransactionID payment[:transaction_id] unless payment[:transaction_id].nil?
          }
        }
      }
    end

  end

end
