module Fishbowl::Errors
  class ConnectionNotEstablished < RuntimeError; end;
  class MissingHost < ArgumentError; end;
  class MissingUsername < ArgumentError; end;
  class MissingPassword < ArgumentError; end;
end
