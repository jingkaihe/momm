# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'momm/version'

Gem::Specification.new do |spec|
  spec.name          = "momm"
  spec.version       = Momm::VERSION
  spec.authors       = ["Jingkai He"]
  spec.email         = ["jaxihe@gmail.com"]
  spec.summary       = %q{A Currency Exchange Calculator}
  spec.description   = %q{A currency exchange calculator build in pure Ruby.}
  spec.homepage      = "https://github.com/jaxi/momm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "dalli", "2.7.6"
  spec.add_development_dependency "redis-namespace", "1.5.2"
  spec.add_development_dependency "rack-test", "0.6.3"
  spec.add_development_dependency "rake", "10.5.0"
  spec.add_development_dependency "sinatra", "1.4.7"
  spec.add_development_dependency "rspec", "3.4.0"
end
