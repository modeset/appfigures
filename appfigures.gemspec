# -*- encoding: utf-8 -*-
require File.expand_path('../lib/appfigures/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jay Zeschin"]
  gem.email         = ["jay.zeschin@modeset.com"]
  gem.description   = %q{Gem wrapper for the AppFigures API}
  gem.summary       = %q{Faraday-based wrapper for the AppFigures REST API}
  gem.homepage      = "https://github.com/modeset/appfigures"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "appfigures"
  gem.require_paths = ["lib"]
  gem.version       = Appfigures::VERSION
  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'faraday_middleware'
  gem.add_runtime_dependency 'multi_json'
  gem.add_runtime_dependency 'hashie'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '>= 2.11'
end
