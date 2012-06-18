module SeleniumRackDriver
  class CheckboxField < FormField

    def click
      if selected?
        native.remove_attribute("checked")
      else
        self[:checked] = "checked"
      end
    end

    def field_value
      self[:value]
    end

    def selected?
      !self[:checked].nil?
    end

    def valid_for_submission?(button)
      selected?
    end

  end
end
