module SeleniumRackDriver
  class InputCheckboxElement < Element

    def field_name
      native[:name]
    end

    def field_value
      native[:value] if checked?
    end

    private

    def checked?
      native[:checked]
    end

  end
end
