module SeleniumRackDriver
  class FormField < Element

    def field_name
      self[:name]
    end

    def field_value
      self[:value] || ""
    end

    def form
      first(:ancestors, 'form')
    end

    def valid_for_click?
      enabled?
    end

    def valid_for_submission?(button)
      true
    end

  end
end
