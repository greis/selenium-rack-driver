module SeleniumRackDriver
  class Driver

    def initialize(opts = {})
    end

    def driver_extensions
      []
    end

    def clearElement(element)
      element.clear
    end

    def clickElement(element)
      element.click
    end

    def elementEquals(element, other)
      element.instance_variable_get('@id') == other.instance_variable_get('@id')
    end

    def find_element_by(how, what, parent = nil)
      find_elements_by(how, what, parent)[0]
    end

    def find_elements_by(how, what, parent = nil)
      finder = parent.nil? ? dom : parent
      elements = case how
                 when 'id'
                   finder.find(:css, "##{what}")
                 when 'name'
                   finder.find(:xpath, ".//*[@name='#{what}']")
                 when 'class name'
                   finder.find(:css, ".#{what}")
                 when 'link text'
                   finder.find(:xpath, ".//*[text()='#{what}']")
                 when 'xpath'
                   finder.find(:xpath, what)
                 when 'css selector'
                   finder.find(:css, what)
                 when 'tag name'
                   finder.find(:xpath, ".//#{what}")
                 else
                   #raise error
                 end
      elements.map do |element|
        ::Selenium::WebDriver::Element.new(self, element)
      end
    end

    def get(url)
      browser.process(:get, url)
    end

    def getCurrentUrl
      browser.current_url
    end

    def getElementAttribute(element, name)
      element[name]
    end

    def getElementText(element)
      element.content
    end

    def getTitle
      dom.first(:xpath, '/html/head/title').content
    end

    def getPageSource
      browser.source
    end

    def isElementEnabled(element)
      element[:disabled].nil?
    end

    def quit
      @browser = nil
    end

    def submitElement(element)
      element.submit
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
