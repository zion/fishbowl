require 'fishbowl/version'
require 'fishbowl/errors'
require 'fishbowl/objects'

module Fishbowl # :nodoc:
  class Connection
    attr_accessor :host, :port, :username, :password

    def initialize(options = {})
      raise Fishbowl::Errors::MissingHost if options[:host].nil?

      @host = options[:host]
      @port = options[:port].nil? ? 28192 : options[:port]
    end

    def login(options = {})
      raise Fishbowl::Errors::MissingUsername if options[:username].nil?
      raise Fishbowl::Errors::MissingPassword if options[:password].nil?

      @username, @password = options[:username], options[:password]

      # TODO: Actually login
    end
  end
end
