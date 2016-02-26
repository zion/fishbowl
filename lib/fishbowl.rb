require 'socket'
require 'base64'
require 'singleton'

require 'nokogiri'

require 'fishbowl/ext'

require 'fishbowl/version'
require 'fishbowl/errors'
require 'fishbowl/requests'
require 'fishbowl/objects'

require 'helpers/configuration'

require 'pry'

module Fishbowl # :nodoc:
  extend Configuration
  # define_setting :app_id
  # define_setting :app_name
  # define_setting :app_description
  # define_setting :username
  # define_setting :password

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
      puts 'opening connection...'
      puts request
      puts 'waiting for response...'
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
            xml.IAID          "10203"
            xml.IAName        "Fishbowl Ruby Gem"
            xml.IADescription "Fishbowl Ruby Gem"
            xml.UserName      @username
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

      puts response
      # puts expectation

      status_code = response.xpath("/FbiXml/#{expectation}").attr("statusCode").value
      # binding.pry

      [status_code, response]
    end

  end
end
