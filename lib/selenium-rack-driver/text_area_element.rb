module SeleniumRackDriver
  class TextAreaElement < Element

    def clear
      native.content = ""
    end

    def field_name
      native[:name]
    end

    def field_value
      native.text
    end

  end
end
