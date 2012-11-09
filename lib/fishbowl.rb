require 'socket'
require 'base64'
require 'singleton'

require 'nokogiri'

require 'fishbowl/version'
require 'fishbowl/errors'
require 'fishbowl/objects'

module Fishbowl # :nodoc:
  class Connection
    include Singleton

    def self.connect(options = {})
      raise Fishbowl::Errors::MissingHost if options[:host].nil?

      @@host = options[:host]
      @@port = options[:port].nil? ? 28192 : options[:port]

      @@connection = TCPSocket.new @@host, @@port

      self.instance
    end

    def self.login(options = {})
      raise Fishbowl::Errors::ConnectionNotEstablished if @@connection.nil?
      raise Fishbowl::Errors::MissingUsername if options[:username].nil?
      raise Fishbowl::Errors::MissingPassword if options[:password].nil?

      @@username, @@password = options[:username], options[:password]

      Fishbowl::Objects::BaseObject.new.send_request(login_request, true)

      # TODO Do something with the response
    end

    def self.host
      @@host
    end

    def self.port
      @@port
    end

    def self.username
      @@username
    end

    def self.password
      @@password
    end

    def self.send(request)
      write(request)
    end

    def self.close
      @@connection.close
      @@connection = nil
    end

  private

    def self.login_request
      Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.LoginRq {
            xml.IAID          "fishbowl-ruby"
            xml.IAName        "Fishbowl Ruby Gem"
            xml.IADescription "Fishbowl Ruby Gem"
            xml.UserName      @@username
            xml.UserPassword  encoded_password
          }
        }
      end
    end

    def self.encoded_password
      Base64.encode64(@@password)
    end

    def self.write(request)
      body = request.to_xml
      size = [body.size].pack("L>")

      @@connection.write(size)
      @@connection.write(body)
    end

  end
end
