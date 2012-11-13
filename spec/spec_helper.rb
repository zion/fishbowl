require 'rubygems'
require 'rspec'

if ENV['CI'] != 'true'
  require 'spork'

  Spork.prefork do
    unless ENV['DRB']
      require 'simplecov'
      SimpleCov.start do
        add_filter "/spec/"
      end
    end

    require 'fishbowl'

    require 'equivalent-xml/rspec_matchers'

    require 'support/examples_loader'
    require 'support/fake_socket'
    require 'support/response_mocks'

    RSpec.configure do |config|
      # some (optional) config here
    end
  end

  Spork.each_run do
    if ENV['DRB']
      require 'simplecov'
      SimpleCov.start do
        add_filter "/spec/"
      end
    end
  end
else
  require 'fishbowl'

  require 'equivalent-xml/rspec_matchers'

  require 'support/examples_loader'
  require 'support/fake_socket'
  require 'support/response_mocks'

  RSpec.configure do |config|
    # some (optional) config here
  end
end
