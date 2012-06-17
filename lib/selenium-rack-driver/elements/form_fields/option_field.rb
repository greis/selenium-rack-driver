module SeleniumRackDriver
  class OptionField < FormField

    def click
      select_field.select_option(self)
    end

    def field_value
      self[:value] || content
    end

    def select
      self[:selected] = "selected"
    end

    def selected?
      !self[:selected].nil?
    end

    def unselect
      native.remove_attribute("selected")
    end

    def valid_for_click?
      true
    end

    private

    def select_field
      first(:ancestors, "select")
    end

  end
end
