# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "etaps/version"

Gem::Specification.new do |s|
  s.name        = "etaps"
  s.version     = Etaps::VERSION
  s.authors     = ["Simon Menke"]
  s.email       = ["simon.menke@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple CLI for Taps}
  s.description = %q{Really simple CLI for Taps}

  s.rubyforge_project = "etaps"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"

  s.add_runtime_dependency "taps"
  s.add_runtime_dependency "childprocess"
end
