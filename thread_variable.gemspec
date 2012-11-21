# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thread_variable/version'

Gem::Specification.new do |gem|
  gem.name          = 'thread_variable'
  gem.version       = ThreadVariable::VERSION
  gem.authors       = ['Andrew Marshall']
  gem.email         = ['andrew@johnandrewmarshall.com']
  gem.description   = %q{Makes it easy to create and use thread-local variables.}
  gem.summary       = %q{Makes it easy to create and use thread-local variables.}
  gem.homepage      = 'http://johnandrewmarshall.com/projects/thread_variable'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
