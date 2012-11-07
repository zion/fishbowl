# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fishbowl/version'

Gem::Specification.new do |gem|
  gem.name          = "fishbowl"
  gem.version       = Fishbowl::VERSION
  gem.authors       = ["James Thompson"]
  gem.email         = ["james@plainprograms.com"]
  gem.description   = %q{Provides an interface to the Fishbowl Inventory API.}
  gem.summary       = %q{Fishbowl Inventory API}
  gem.homepage      = "https://github.com/readyproject/fishbowl"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'nokogiri', '~> 1.5.5'
end
