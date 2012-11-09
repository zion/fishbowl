module Fishbowl::Errors
  class ConnectionNotEstablished < RuntimeError; end;
  class MissingHost < ArgumentError; end;
  class MissingUsername < ArgumentError; end;
  class MissingPassword < ArgumentError; end;

  class StatusError < RuntimeError; end;

  def self.confirm_success_or_raise(code, message)
    code.to_i == 1000 ? true : raise(StatusError, message)
  end
end
