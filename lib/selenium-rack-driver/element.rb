module SeleniumRackDriver
  class Element

    attr_reader :native

    def self.for(native)
      Element.new(native)
    end

    def initialize(native)
      @native = native
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

    def find(type, expression)
      elements = case type
      when :xpath
        native.xpath(expression)
      when :css
        native.css(expression)
      end
      elements.map do |element|
        self.class.for(element)
      end
    end

    def first(type, expression)
      element = case type
      when :xpath
        native.at_xpath(expression)
      when :css
        native.at_css(expression)
      end
      self.class.for(element)
    end

    def hash
      native.hash
    end

    def name
      native.name
    end

  end
end
