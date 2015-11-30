# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/reporters/parallel_tests_reporter'

Gem::Specification.new do |spec|
  spec.name          = "minitest-reporters-parallel_tests_reporter"
  spec.version       = Minitest::Reporters::ParallelTestsReporter::VERSION
  spec.authors       = ["Josh Bodah"]
  spec.email         = ["jb3689@yahoo.com"]

  spec.summary       = %q{a minitest-reporter extension for integrating with parallel_tests}
  spec.description   = %q{a minitest-reporter extension for integrating with parallel_tests. designed to integrate with parallel_tests-extensions}
  spec.homepage      = "https://github.com/backupify/minitest-reporters-parallel_tests_reporter"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
