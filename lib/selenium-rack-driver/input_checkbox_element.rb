module SeleniumRackDriver
  class InputCheckboxElement < InputElement

    def field_value
      native[:value] if checked?
    end

    private

    def checked?
      native[:checked]
    end

  end
end
