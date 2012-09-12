# -*- encoding: utf-8 -*-
require File.expand_path('../lib/disqussed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michael Carey"]
  gem.email         = ["mcarey@stippleit.com"]
  gem.description   = %q{Lightweight wrapper around the Disqus V3 API}
  gem.summary       = %q{Disqus V3 API Wrapper}
  gem.homepage      = ""

  gem.add_dependency "httparty"
  gem.add_dependency "multi_json"
  gem.add_dependency "active_support"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "fakeweb"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "disqussed"
  gem.require_paths = ["lib"]
  gem.version       = Disqussed::VERSION
end
