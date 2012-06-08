module SeleniumRackDriver
  class InputElement < Element

    def clear
      native[:value] = ""
    end

    def field_name
      native[:name]
    end

    def field_value
      native[:value] || ""
    end

  end
end
