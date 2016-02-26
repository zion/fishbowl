require './lib/fishbowl'
require 'pry'

# binding.pry

puts 'connecting...'
Fishbowl::Connection.connect(:host => "199.119.85.202")
# Fishbowl::Connection.login(:username => "Simeon", :password => "b675049cbe7dda8a92089a709272d1d1")
puts 'logging in...'
Fishbowl::Connection.login(:username => "Simeon", :password => "7653a0a36682709d6f7f5f696b12664a")
puts 'carrier list...'
Fishbowl::Requests.get_carrier_list