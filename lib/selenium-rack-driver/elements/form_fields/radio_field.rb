module SeleniumRackDriver
  class RadioField < FormField

    def field_value
      self[:value]
    end

    def valid_for_submission?(button)
      self[:checked]
    end

  end
end
