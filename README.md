# Fishbowl

Provides an interface to the Fishbowl Inventory API.

[![Build Status](https://travis-ci.org/readyproject/fishbowl.png)](https://travis-ci.org/readyproject/fishbowl)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/readyproject/fishbowl)
[![Dependency Status](https://gemnasium.com/readyproject/fishbowl.png)](https://gemnasium.com/readyproject/fishbowl)

## Requirements

A Ruby 1.9 compatible interpreter

## Installation

Add this line to your application's Gemfile:

    gem 'fishbowl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fishbowl

## Usage

Add this to your initializers

```ruby
Fishbowl.configure do |config|
  config.username = "joe"
  config.password = "joes_password"
  config.host = "999.888.77.666"
  config.app_id = "1234"
  config.app_name = "Fishbowl Ruby Gem"
  config.app_description = "Fishbowl Ruby Gem"
  config.debug = true
end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
