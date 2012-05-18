require 'selenium-webdriver'

class Selenium::WebDriver::Driver

  class << self
    alias original_for for

    def for(browser, opts = {})
      if browser == :rack
        bridge = SeleniumRackDriver::Driver.new(opts)
        listener = opts.delete(:listener)
        bridge = Support::EventFiringBridge.new(bridge, listener) if listener
        new(bridge)
      else
        original_for(browser, opts)
      end
    end
  end

end
