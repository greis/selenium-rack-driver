module SeleniumRackDriver
  class OptionElement < Element

    def field_value
      native[:value] || native.text
    end

  end
end
