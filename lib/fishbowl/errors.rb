require 'yaml'

module Fishbowl
  module Errors
    class ConnectionNotEstablished < RuntimeError; end;
    class MissingHost < ArgumentError; end;
    class MissingUsername < ArgumentError; end;
    class MissingPassword < ArgumentError; end;
    class EmptyResponse < RuntimeError; end;

    class StatusError < RuntimeError; end;

    def self.confirm_success_or_raise(code)
      (code.to_i.eql? 1000) ? true : raise(StatusError, get_status(code))
    end

    def self.get_status(code)
      status_codes = YAML.load_file('./lib/status_codes.yml')['codes']
      status_codes[code]['message']
    end
  end
end
