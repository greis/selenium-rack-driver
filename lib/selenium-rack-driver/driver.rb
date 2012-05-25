module SeleniumRackDriver
  class Driver

    def initialize(opts = {})
    end

    def driver_extensions
      []
    end

    def clearElement(element)
      if element.name == "textarea"
        element.content = ""
      elsif element.name == "input" && element[:type] == "text"
        element[:value] = ""
      end
    end

    def clickElement(node)
      if node.name == 'a'
        browser.process(:get, node[:href])
      end
    end

    def find_element_by(how, what, parent = nil)
      find_elements_by(how, what, parent)[0]
    end

    def find_elements_by(how, what, parent = nil)
      finder = parent.nil? ? dom : parent
      elements = case how
                 when 'id'
                   finder.css("##{what}")
                 when 'name'
                   finder.xpath("//*[@name='#{what}']")
                 when 'class name'
                   finder.css(".#{what}")
                 when 'link text'
                   finder.xpath("//*[text()='#{what}']")
                 when 'xpath'
                   finder.xpath(what)
                 when 'css selector'
                   finder.css(what)
                 when 'tag name'
                   finder.xpath("//#{what}")
                 else
                   #raise error
                 end
      elements.map do |node|
        ::Selenium::WebDriver::Element.new(self, node)
      end
    end

    def get(url)
      browser.process(:get, url)
    end

    def getElementAttribute(element, name)
      element[name]
    end

    def getElementText(element)
      element.text
    end

    def getTitle
      dom.at_xpath('/html/head/title').text
    end

    def getPageSource
      browser.source
    end

    def elementEquals(element, other)
      element.instance_variable_get('@id') == other.instance_variable_get('@id')
    end

    def isElementEnabled(element)
      element[:disabled].nil?
    end

    def quit
      @browser = nil
    end

    def sendKeysToElement(element, keys)
      element[:value] = keys.join
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
