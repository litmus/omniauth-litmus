# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/litmus/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-litmus"
  spec.version       = Omniauth::Litmus::VERSION
  spec.authors       = ["Rahim Packir Saibo"]
  spec.email         = ["rahim@litmus.com"]

  spec.summary       = %q{Official OmniAuth strategy for Litmus}
  spec.description   = %q{Official OmniAuth strategy for Litmus}
  spec.homepage      = "https://github.com/litmus/omniauth-litmus"
  spec.license       = "MIT"

  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.name          = "omniauth-litmus"
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
