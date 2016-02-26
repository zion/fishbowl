require './lib/fishbowl'
require 'pry'

puts 'CONNECT ---'
Fishbowl::Connection.connect(:host => "199.119.85.202")
puts 'LOGIN ---'
Fishbowl::Connection.login(:username => "Simeon", :password => "covercrops2")

puts 'carrier list...'
carriers = Fishbowl::Requests.get_carrier_list
carriers.each do |carrier|
  puts carrier
end