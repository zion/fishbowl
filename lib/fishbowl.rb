require 'socket'
require 'base64'
require 'singleton'

require 'nokogiri'

require 'fishbowl/ext'

require 'fishbowl/version'
require 'fishbowl/errors'
require 'fishbowl/requests'
require 'fishbowl/objects'

require 'pry'

module Fishbowl # :nodoc:
  class Connection
    include Singleton

    def self.connect(options = {})
      raise Fishbowl::Errors::MissingHost if options[:host].nil?

      @host = options[:host]
      @port = options[:port].nil? ? 28192 : options[:port]

      @connection = TCPSocket.new @host, @port

      self.instance
    end

    def self.login(options = {})
      raise Fishbowl::Errors::ConnectionNotEstablished if @connection.nil?
      raise Fishbowl::Errors::MissingUsername if options[:username].nil?
      raise Fishbowl::Errors::MissingPassword if options[:password].nil?

      @username, @password = options[:username], options[:password]

      code, message, _ = Fishbowl::Objects::BaseObject.new.send_request(login_request)
      Fishbowl::Errors.confirm_success_or_raise(code, message)



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

    def self.send(request, expected_response = 'FbiMsgRs')
      puts request
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
            xml.IAID          "zYjEsXTmmb2QD4iGMTeF-smartmix-fishbowl-integration"
            xml.IAName        "Fishbowl Ruby Gem"
            xml.IADescription "Fishbowl Ruby Gem"
            xml.UserName      @username
            xml.UserPassword  encoded_password
          }
        }
      end
    end

    def self.encoded_password
      Base64.encode64(@password)
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

      status_code = "1000"
      status_message = ""
      puts 'response: '
      puts response
      [status_code, status_message, response]
    end

  end
end
