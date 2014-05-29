# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schemaless_field/version'

Gem::Specification.new do |spec|
  spec.name          = "schemaless_field"
  spec.version       = SchemalessField::VERSION
  spec.authors       = ["Stan Bondi"]
  spec.email         = ["stan@fixate.it"]
  spec.summary       = %q{Basic accessor methods for schemaless ORM fields.}
  spec.description   = <<-TXT
  Basic accessor methods for schemaless ORM fields.
  For e.g. a JSON field in Postgres.
  TXT
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "jsonpath", "~> 0.5.6"
  spec.add_dependency "activesupport", "> 2"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
