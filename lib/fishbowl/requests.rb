module Fishbowl; module Requests; end; end

Dir.glob(File.join(File.expand_path("../requests/", __FILE__), "**.rb")).each do |file|
  require file
end
