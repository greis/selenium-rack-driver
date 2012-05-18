Gem::Specification.new do |s|
  s.name        = 'selenium-rack-test'
  s.version     = '0.0.1'
  s.date        = '2012-05-18'
  s.summary     = "Selenium Rack Test"
  s.description = "Another implementation for browser driven tests"
  s.authors     = ["Gabriel Reis", "Thais Camilo"]
  s.email       = 'narwen+greis@gmail.com'
  s.files       = ["lib/selenium-rack-test.rb"]
  s.homepage    = 'http://rubygems.org/gems/selenium-rack-test'
  s.add_runtime_dependency("selenium-webdriver", ["~> 2.0"])
end
