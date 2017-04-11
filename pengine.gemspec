$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pengine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pengine"
  s.version     = Pengine::VERSION
  s.authors     = ["linyows"]
  s.email       = ["linyows@gmail.com"]
  s.homepage    = "https://github.com/linyows/pengine"
  s.summary     = "The Pengin is PowerDNS API mountable engine for Rails."
  s.description = "The Pengin is PowerDNS API mountable engine for Rails."
  s.license     = "MIT"
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2.7"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "sqlite3"
end
