# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gitki/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Guillaume Garcera"]
  gem.email         = ["guillaume.garcera@gmail.com"]
  gem.description   = %q{Build your own wiki with markdown and git}
  gem.summary       = %q{Wiki made simple with markdown and git}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "gitki"
  gem.require_paths = ["lib"]
  gem.version       = Gitki::VERSION


  gem.add_dependency "thor"
  gem.add_dependency "redcarpet"
  gem.add_dependency "tilt"
  gem.add_dependency "active_support"
  gem.add_dependency "pygments.rb"
  gem.add_dependency "confstruct"
end
