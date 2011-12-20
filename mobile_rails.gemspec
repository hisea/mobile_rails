# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mobile_rails/version"

Gem::Specification.new do |s|
  s.name        = "mobile_rails"
  s.version     = MobileRails::VERSION
  s.authors     = ["Hisea"]
  s.email       = ["zyinghai@gmail.com"]
  s.homepage    = "https://github.com/hisea/mobile_rails"
  s.summary     = %q{Gem for easy creation of mobile enabled rails app.}
  s.description = %q{Gem for easy creation of mobile enabled rails app.}

  s.rubyforge_project = "mobile_rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  # s.add_runtime_dependency "rest-client"
end
