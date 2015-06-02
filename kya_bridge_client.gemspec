# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kya_bridge_client/version'

Gem::Specification.new do |spec|
  spec.name          = "kya_bridge_client"
  spec.version       = KyaBridgeClient::VERSION
  spec.authors       = ["Sam Phippen"]
  spec.email         = ["samphippen@googlemail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = " to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{the summary}
  spec.description   = %q{the description}
  spec.homepage      = "the url"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
