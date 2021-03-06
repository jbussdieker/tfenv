# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tfenv/version'

Gem::Specification.new do |spec|
  spec.name          = "tfenv"
  spec.version       = Tfenv::VERSION
  spec.authors       = ["Joshua B. Bussdieker"]
  spec.email         = ["jbussdieker@gmail.com"]

  spec.summary       = %q{Simple tool for loading external module outputs.}
  spec.homepage      = "https://github.com/jbussdieker/tfenv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4", ">= 3.4.0"
end
