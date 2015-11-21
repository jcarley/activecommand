# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_command/version'

Gem::Specification.new do |spec|
  spec.name          = "activecommand"
  spec.version       = ActiveCommand::VERSION
  spec.authors       = ["Jefferson Carley"]
  spec.email         = ["jeff.carley@gmail.com"]

  spec.summary       = %q{ActiveCommand adds the ability to use the command pattern commonly seen in CQRS.}
  spec.homepage      = "https://github.com/jcarley/activecommand"
  spec.license       = "MIT"

  spec.add_dependency 'virtus'
  spec.add_dependency 'middleware'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'activemodel'
  spec.add_dependency 'activejob'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
