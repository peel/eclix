# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eclix/version'

Gem::Specification.new do |spec|
  spec.name          = "eclix"
  spec.version       = Eclix::VERSION
  spec.authors       = ["Piotr Limanowski"]
  spec.email         = ["piotr.limanowski@schibsted.pl"]
  spec.summary       = "A CLI interface to Escenic CMS"
  spec.description   = "A CLI interface to Escenic CMS"
  spec.homepage      = "https://github.com/peel/eclix"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "coveralls"

  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "commander"
  spec.add_runtime_dependency "net-scp"
end
