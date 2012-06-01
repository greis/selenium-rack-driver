require 'selenium-rack-driver/selenium_web_driver'
require 'nokogiri'
require 'rack/test'

module SeleniumRackDriver

  autoload :Browser, 'selenium-rack-driver/browser'
  autoload :Driver,  'selenium-rack-driver/driver'
  autoload :Element,  'selenium-rack-driver/element'
  autoload :FormElement,  'selenium-rack-driver/form_element'

  class << self
    attr_accessor :app
  end

end
