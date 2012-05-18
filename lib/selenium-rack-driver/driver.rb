module SeleniumRackDriver
  class Driver

    def initialize(opts = {})
    end

    def driver_extensions
      []
    end

    def clickElement(node)
      if node.name == 'a'
        browser.process(:get, node[:href])
      end
    end

    def find_element_by(how, what, parent = nil)
      selector = "#" + what
      elements = dom.css(selector).map do |node|
        ::Selenium::WebDriver::Element.new(self, node)
      end
      elements[0]
    end

    def get(url)
      browser.process(:get, url)
    end

    def getPageSource
      browser.source
    end

    def quit
      @browser = nil
    end

    private

    def browser
      @browser ||= Browser.new
    end

    def dom
      browser.dom
    end

  end
end
