module SeleniumRackDriver
  class TextAreaField < FormField

    def clear
      self.content = ""
    end

    def field_value
      content
    end

  end
end
