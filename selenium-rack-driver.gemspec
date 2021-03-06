Gem::Specification.new do |s|
  s.name        = 'selenium-rack-driver'
  s.version     = '0.0.1'
  s.date        = '2012-05-18'
  s.summary     = "Selenium Rack Driver"
  s.description = "Another implementation for browser driven tests"
  s.authors     = ["Gabriel Reis", "Thais Camilo"]
  s.email       = 'narwen+greis@gmail.com'
  s.files       = ["lib/selenium-rack-driver.rb"]
  s.homepage    = 'http://rubygems.org/gems/selenium-rack-driver'

  s.add_runtime_dependency("selenium-webdriver", ["~> 2.0"])
  s.add_runtime_dependency("mime-types", [">= 1.16"])
  s.add_runtime_dependency("nokogiri", [">= 1.3.3"])
  s.add_runtime_dependency("rack", [">= 1.0.0"])
  s.add_runtime_dependency("rack-test", [">= 0.5.4"])

  s.add_development_dependency("sinatra", [">= 0.9.4"])
  s.add_development_dependency("rspec", [">= 2.2.0"])
end
