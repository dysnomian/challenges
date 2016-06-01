# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'challenges/version'

Gem::Specification.new do |spec|
  spec.name          = "challenges"
  spec.version       = Challenges::VERSION
  spec.authors       = ["Liss McCabe"]
  spec.email         = ["liss@eristiccode.com"]

  spec.summary       = "Liss's answers to Ruby programming challenges."
  spec.description   = "Liss's answers to Ruby programming challenges."
  spec.homepage      = "https://github.com/dysnomian/challenges"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "funtools", "~> 0.7.1"
end
