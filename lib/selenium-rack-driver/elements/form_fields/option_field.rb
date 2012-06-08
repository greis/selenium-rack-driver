module SeleniumRackDriver
  class OptionField < FormField

    def field_value
      native[:value] || native.text
    end

  end
end
