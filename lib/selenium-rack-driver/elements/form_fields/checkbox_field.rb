module SeleniumRackDriver
  class CheckboxField < FormField

    def field_value
      self[:value]
    end

    def valid_for_submission?(button)
      self[:checked]
    end

  end
end
