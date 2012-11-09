require 'support/fake_socket'

def mock_login_response
  fake_login_response = Nokogiri::XML::Builder.new do |xml|
    xml.FbiXml {
      xml.Ticket

      xml.FbiMsgsRs(statusCode: '1000', statusMessage: "Success!") {
        xml.LoginRs(statusCode: '1000', statusMessage: "Success!")
      }
    }
  end

  FakeTCPSocket.instance.set_canned(fake_login_response.to_xml)
end
