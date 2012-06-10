module SeleniumRackDriver
  class CheckboxField < FormField

    def field_value
      native[:value]
    end

    def valid_for_submission?(button)
      native[:checked]
    end

  end
end
