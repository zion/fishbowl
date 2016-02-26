require './lib/fishbowl'
require 'pry'

Fishbowl.configure do |config|
  config.username = "Simeon"
  config.password = "covercrops2"
  config.host = "199.119.85.202"
  config.app_id = "10203"
  config.app_name = "Fishbowl Ruby Gem"
  config.app_description = "Fishbowl Ruby Gem"
end

Fishbowl::Connection.connect
Fishbowl::Connection.login
carriers = Fishbowl::Requests.get_carrier_list
puts carriers