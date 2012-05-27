module SeleniumRackDriver
  class Node

    attr_reader :native

    def self.for(native)
      Node.new(native)
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
      nodes = case type
      when :xpath
        native.xpath(expression)
      when :css
        native.css(expression)
      end
      nodes.map do |node|
        self.class.for(node)
      end
    end

    def first(type, expression)
      node = case type
      when :xpath
        native.at_xpath(expression)
      when :css
        native.at_css(expression)
      end
      self.class.for(node)
    end

    def hash
      native.hash
    end

    def name
      native.name
    end

  end
end
