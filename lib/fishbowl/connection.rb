module Fishbowl
  class Connection
    include Singleton

    def self.connect()
      raise Fishbowl::Errors::MissingHost if Fishbowl.configuration.host.nil?

      @host = Fishbowl.configuration.host
      @port = Fishbowl.configuration.port.nil? ? 28192 : Fishbowl.configuration.port

      @connection = TCPSocket.new @host, @port

      self.instance
    end

    def self.login()
      raise Fishbowl::Errors::ConnectionNotEstablished if @connection.nil?

      @username = Fishbowl.configuration.username
      @password = Fishbowl.configuration.password

      code, _ = Fishbowl::Objects::BaseObject.new.send_request(login_request)
      Fishbowl::Errors.confirm_success_or_raise(code)

      self.instance
    end

    def self.host
      @host
    end

    def self.port
      @port
    end

    def self.username
      @username
    end

    def self.password
      @password
    end

    def self.send(request, expected_response = 'FbiMsgsRs')
      puts 'opening connection...' if Fishbowl.configuration.debug.eql? true
      puts request if Fishbowl.configuration.debug.eql? true
      puts 'waiting for response...' if Fishbowl.configuration.debug.eql? true
      write(request)
      get_response(expected_response)
    end

    def self.close
      @connection.close
      @connection = nil
    end

    private

    def self.login_request
      Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.LoginRq {
            xml.IAID          Fishbowl.configuration.app_id
            xml.IAName        Fishbowl.configuration.app_name
            xml.IADescription Fishbowl.configuration.app_description
            xml.UserName      Fishbowl.configuration.username
            xml.UserPassword  encoded_password
          }
        }
      end
    end

    def self.encoded_password
      Digest::MD5.base64digest(@password)
    end

    def self.write(request)
      body = request.to_xml
      size = [body.size].pack("L>")
      @connection.write(size)
      @connection.write(body)
    end

    def self.get_response(expectation)
      length = @connection.recv(4).unpack('L>').join('').to_i
      response = Nokogiri::XML.parse(@connection.recv(length))

      puts "Looking for '#{expectation}' node in: " if Fishbowl.configuration.debug.eql? true
      puts response if Fishbowl.configuration.debug.eql? true

      status_code = response.xpath("/FbiXml/#{expectation}").attr("statusCode").value

      [status_code, response]
    end

  end
end