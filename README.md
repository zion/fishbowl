# Fishbowl

Provides an interface to the Fishbowl Inventory API.

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

Add this to your env.rb file or as an initializer

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
```

Now you are setup to make API calls in your application code

```ruby
Fishbowl::Connection.connect
Fishbowl::Connection.login
carriers = Fishbowl::Requests.get_carrier_list
```

The 'connect' method establishes the connection socket to the server, the 'login' method authenticates the connection to the server using a username and password.

Once the login method is successful (The Fishbowl API responds with statusCode=1000 for successful requests, see a [complete list](../master/lib/status_codes.yml) of status codes)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
