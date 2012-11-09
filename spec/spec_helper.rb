require 'rubygems'
require 'bundler/setup'

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'equivalent-xml/rspec_matchers'

require 'fishbowl'

require 'support/fake_socket'

RSpec.configure do |config|
  # some (optional) config here
end
