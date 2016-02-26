require './lib/fishbowl'
require 'pry'

# binding.pry

puts 'CONNECT ---'
Fishbowl::Connection.connect(:host => "199.119.85.202")
puts 'LOGIN ---'
Fishbowl::Connection.login(:username => "Simeon", :password => "covercrops2")

puts 'carrier list...'
Fishbowl::Requests.get_carrier_list