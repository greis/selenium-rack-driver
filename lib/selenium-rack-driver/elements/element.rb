module SeleniumRackDriver
  class Element

    attr_reader :native, :browser

    def self.for(native, browser)
      element_class = case native.name
                      when "a"
                        AnchorElement
                      when "form"
                        FormElement
                      when "input"
                        case native[:type]
                        when "button", "reset"
                          Button
                        when "checkbox"
                          CheckboxField
                        when "file"
                          FileField
                        when "radio"
                          RadioField
                        when "submit", "image"
                          SubmitField
                        else
                          TextField
                        end
                      when "button"
                        case native[:type]
                        when "button", "reset"
                          Button
                        else
                          SubmitField
                        end
                      when "option"
                        OptionField
                      when "select"
                        SelectField
                      when "textarea"
                        TextAreaField
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

    def enabled?
      self[:disabled].nil?
    end

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
