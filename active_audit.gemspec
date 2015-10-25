$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_audit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_audit"
  s.version     = ActiveAudit::VERSION
  s.authors     = ["aquinofb"]
  s.email       = ["aquinofb@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "A simple way to add active audit to your Rails app"
  s.description = "A simple way to add active audit to your Rails app"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
