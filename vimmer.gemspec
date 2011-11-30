# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vimmer/version"

Gem::Specification.new do |s|
  s.name        = "vimmer"
  s.version     = Vimmer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joe Fiorini"]
  s.email       = ["joe@densitypop.com"]
  s.homepage    = "http://rubygems.org/gems/vimmer"
  s.summary     = %q{Automated Vim plugin management}
  s.description = %q{Install, update and remove Vim plugins without changing directories using this simple command line utility.}

  s.rubyforge_project = "vimmer"

  s.add_dependency "thor"

  s.add_development_dependency "bundler", ">=1.0.0"
  s.add_development_dependency "rspec", "~> 2.7.0"
  s.add_development_dependency "cucumber", "~> 1.1.3"
  s.add_development_dependency "autotest"
  s.add_development_dependency "fuubar"
  s.add_development_dependency "fakefs"
  s.add_development_dependency "aruba",  "~> 0.4.7"
  s.add_development_dependency "mocha"
  s.add_development_dependency "bourne"
  s.add_development_dependency "webmock"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
