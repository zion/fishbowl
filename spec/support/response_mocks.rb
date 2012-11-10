require 'support/fake_socket'

def mock_response(response = 'SampleRs')
  Nokogiri::XML::Builder.new do |xml|
    xml.FbiXml {
      xml.Ticket

      xml.FbiMsgsRs(statusCode: '1000', statusMessage: "Success!") {
        if response.respond_to?(:to_xml)
          xml << response.doc.xpath("response/*").to_xml
        else
          xml.send(response, {statusCode: '1000', statusMessage: "Success!"})
        end
      }
    }
  end
end

def mock_the_response(response = 'SampleRs')
  fake_response = mock_response(response)
  FakeTCPSocket.instance.set_canned(fake_response.to_xml)
end

def mock_login_response
  fake_response = mock_response('LoginRs')
  FakeTCPSocket.instance.set_canned(fake_response.to_xml)
end
