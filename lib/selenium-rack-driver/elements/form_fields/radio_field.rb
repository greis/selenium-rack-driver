module SeleniumRackDriver
  class RadioField < FormField

    def click
      uncheck_fields
      self[:checked] = "checked"
    end

    def field_value
      self[:value]
    end

    def selected?
      !self[:checked].nil?
    end

    def valid_for_click?
      form
    end

    def valid_for_submission?(button)
      selected?
    end

    private

    def uncheck_fields
      form.find(:css, "input[type=radio]").each do |input|
        if input[:name] == self[:name] && input.selected?
          input.native.remove_attribute("checked")
        end
      end
    end

  end
end
