module SeleniumRackDriver
  class Element

    attr_reader :native, :browser

    def self.for(native, browser)
      element_class = if native.name == "form"
        FormElement
      elsif native.name == "textarea"
        TextAreaElement
      elsif native.name == "select"
        SelectElement
      elsif native.name == "option"
        OptionElement
      elsif native.name == "input" && native[:type] == "text"
        InputTextElement
      elsif native.name == "input" && native[:type] == "checkbox"
        InputCheckboxElement
      elsif native.name == "input" && native[:type] == "radio"
        InputRadioElement
      elsif native.name == "input" && native[:type] == "file"
        InputFileElement
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
      when :ancestors
        native.ancestors(expression)
      end
      elements.map do |element|
        self.class.for(element, browser)
      end
    end

    def first(type, expression)
      find(type, expression).first
    end

    def hash
      native.hash
    end

    def tag_name
      native.name
    end

  end
end
