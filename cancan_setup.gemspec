$:.push File.expand_path("../lib", __FILE__)
require "cancan_setup/version"

Gem::Specification.new do |s|
  s.name        = "cancan_setup"
  s.version     = CanCanSetup::VERSION
  s.authors     = ["Oleg Yashchuk"]
  s.email       = ["oazoer@gmail.com"]
  s.homepage    = "http://github.com/zoer/cancan_setup"
  s.summary     = "Setup CanCan from multiple engines."
  s.description = "Setup CanCan from multiple engines."

  s.files = Dir["{lib,spec}/**/*"] + ["MIT-LICENSE"] - ["Gemfile.lock"]

  s.add_development_dependency 'rspec', '~> 2.13.0'
end