$:.push File.expand_path('../lib', __FILE__)
require 'version'

Gem::Specification.new do |s|

  s.name        = 'parsi-date'
  s.version     = Parsi::Date::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.author      = 'Hassan Zamani'
  s.email       = 'hsn.zamani@gmail.com'
  s.homepage    = 'http://github.com/hzamani/parsi-date'
  s.summary     = 'Solar Hijri (Jalali, Persian, Parsi) date library for Ruby'
  s.description = "A Solar Hijri (Jalali) date library for Ruby, whitch provides much of Ruby's built-in date class"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency("bundler", "~> 1.4")
  s.add_development_dependency("rake", "~> 10.0")
  s.add_development_dependency("rspec", "~> 2.0")
end
