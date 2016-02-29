require 'socket'
require 'base64'
require 'singleton'

require 'nokogiri'

require 'fishbowl/ext'

require 'fishbowl/version'
require 'fishbowl/errors'
require 'fishbowl/requests'
require 'fishbowl/objects'
require 'fishbowl/connection'
require 'fishbowl/configuration'

module Fishbowl # :nodoc:

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

end
