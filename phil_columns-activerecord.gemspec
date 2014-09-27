# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phil_columns/activerecord/version'

Gem::Specification.new do |spec|
  spec.name          = "phil_columns-activerecord"
  spec.version       = PhilColumns::Activerecord::VERSION
  spec.authors       = ["C. Jason Harrelson (midas)"]
  spec.email         = ["jason@lookforwardenterprises.com"]
  spec.summary       = %q{Adapter for activerecord.}
  spec.description   = %q{Adapter for activerecord.  See README for more details.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "activerecord"
end
