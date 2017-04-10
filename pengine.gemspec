# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pengine/version'

Gem::Specification.new do |spec|
  spec.name          = "pengine"
  spec.version       = Pengine::VERSION
  spec.authors       = ["linyows"]
  spec.email         = ["linyows@gmail.com"]

  spec.summary       = %q{The Pengin is PowerDNS API mountable engine for Rails.}
  spec.description   = %q{The Pengin is PowerDNS API mountable engine for Rails.}
  spec.homepage      = "https://github.com/linyows/pengine"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
