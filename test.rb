require './lib/fishbowl'
require 'pry'

# binding.pry

puts 'CONNECT ---'
Fishbowl::Connection.connect(:host => "199.119.85.202")
puts 'LOGIN ---'
Fishbowl::Connection.login(:username => "Simeon", :password => "dlOgo2aCcJ1vf19paxJmSg==")

puts 'carrier list...'
Fishbowl::Requests.get_carrier_list