require 'socket'
require 'base64'

require 'nokogiri'

require 'fishbowl/version'
require 'fishbowl/errors'
require 'fishbowl/objects'

module Fishbowl # :nodoc:
  class Connection
    attr_reader :host, :port, :username, :password

    def initialize(options = {})
      raise Fishbowl::Errors::MissingHost if options[:host].nil?

      @host = options[:host]
      @port = options[:port].nil? ? 28192 : options[:port]

      @connection = ::TCPSocket.new @host, @port
    end

    def login(options = {})
      raise Fishbowl::Errors::MissingUsername if options[:username].nil?
      raise Fishbowl::Errors::MissingPassword if options[:password].nil?

      @username, @password = options[:username], options[:password]

      builder = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml FbiMsgsRq{
            xml LoginRq {
              xml.IAID          "fishbowl-ruby"
              xml.IAName        "Fishbowl Ruby Gem"
              xml.IADescription "Fishbowl Ruby Gem"
              xml.UserName      @username
              xml.UserPassword  encoded_password
            }
          }
        }
      end

      request = builder.to_xml

      @connection.write([request.size].pack("L>"))
      @connection.write(request)

      # TODO Do something with the response
    end

    def close
      @connection.close
    end

  private

    def encoded_password
      Base64.encode64(@password)
    end

  end
end
