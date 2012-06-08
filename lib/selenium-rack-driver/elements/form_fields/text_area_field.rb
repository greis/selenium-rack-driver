module SeleniumRackDriver
  class TextAreaField < FormField

    def clear
      native.content = ""
    end

    def field_value
      native.text
    end

  end
end
