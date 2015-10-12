# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infoblox_client/version'

Gem::Specification.new do |spec|
  spec.name          = "infoblox_client"
  spec.version       = InfobloxClient::VERSION
  spec.authors       = ["Pyankov Evgeniy"]
  spec.email         = ["pyankov.ev@gmail.com"]
  spec.summary       = %q{Simple Ruby client for the Infoblox WAP}
  spec.description   = %q{Client for create and manage dns zones and records}
  spec.homepage      = "https://github.com/things23/infoblox_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.0'

  spec.add_runtime_dependency "httpclient"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
