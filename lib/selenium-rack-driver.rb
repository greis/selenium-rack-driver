require 'selenium-rack-driver/selenium_web_driver'
require 'nokogiri'
require 'rack/test'

module SeleniumRackDriver

  autoload :Browser, 'selenium-rack-driver/browser'
  autoload :Driver,  'selenium-rack-driver/driver'

  class << self
    attr_accessor :app
  end

end
