module Fishbowl
  class Configuration
    attr_accessor :username, :password, :host, :port, :app_id, :app_name, :app_description, :debug

    def initialize
      @debug = false
    end
  end
end