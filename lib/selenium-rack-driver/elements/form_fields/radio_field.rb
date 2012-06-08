module SeleniumRackDriver
  class RadioField < FormField

    def field_value
      native[:value] if checked?
    end

    private

    def checked?
      native[:checked]
    end

  end
end
