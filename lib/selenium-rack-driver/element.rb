module SeleniumRackDriver
  class Element

    attr_reader :native, :browser

    def self.for(native, browser)
      element_class = if native.name == "form"
        FormElement
      elsif native.name == "textarea"
        TextAreaElement
      elsif native.name == "input" && native[:type] == "text"
        InputTextElement
      else
        Element
      end
      element_class.new(native, browser)
    end

    def initialize(native, browser)
      @native = native
      @browser = browser
    end

    def [](attribute)
      native[attribute]
    end

    def []=(attribute, value)
      native[attribute] = value
    end

    def ==(other)
      native == other.native
    end

    def content
      native.content
    end

    def content=(content)
      native.content = content
    end

    def clear; end

    def find(type, expression)
      elements = case type
      when :xpath
        native.xpath(expression)
      when :css
        native.css(expression)
      end
      elements.map do |element|
        self.class.for(element, browser)
      end
    end

    def first(type, expression)
      element = case type
      when :xpath
        native.at_xpath(expression)
      when :css
        native.at_css(expression)
      end
      self.class.for(element, browser)
    end

    def hash
      native.hash
    end

    def tag_name
      native.name
    end

  end
end
