# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dm-perspectives/version'

Gem::Specification.new do |spec|
  spec.name          = "dm-perspectives"
  spec.version       = DataMapper::Perspectives::VERSION
  spec.authors       = ["Asher"]
  spec.email         = ["asher@okbreathe.com"]
  spec.summary       = %q{Presenters for DataMapper models}
  spec.description   = %q{Presenters for DataMapper models}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  RAILS_VERSION = '>= 3.0.3'
  DM_VERSION    = '>= 1.0.2'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "shoulda", ">= 0"
  spec.add_development_dependency "rr"

  spec.add_dependency "tzinfo",              ">=0.3.23"

  spec.add_dependency "activesupport",        RAILS_VERSION

  spec.add_dependency 'dm-sqlite-adapter',    DM_VERSION
  spec.add_dependency 'dm-migrations',        DM_VERSION
  spec.add_dependency 'dm-types',             DM_VERSION
  spec.add_dependency 'dm-validations',       DM_VERSION

  spec.add_dependency 'dm-core',              DM_VERSION
  spec.add_dependency 'dm-do-adapter',        DM_VERSION
  spec.add_dependency 'dm-active_model',      DM_VERSION
end



