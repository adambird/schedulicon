$:.push File.expand_path("../lib", __FILE__)
require "schedulicon/version"

Gem::Specification.new do |s|
  s.name        = "schedulicon"
  s.version     = Schedulicon::VERSION.dup
  s.platform    = Gem::Platform::RUBY 
  s.summary     = "Gem for recurring events"
  s.email       = "adam.bird@gmail.com"
  s.homepage    = "http://github.com/adambird/schedulicon"
  s.description = "Gem for recurring events"
  s.authors     = ['Adam Bird']

  s.files         = Dir["lib/**/*"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]

end