module SeleniumRackDriver
  class FormField < Element

    def field_name
      native[:name]
    end

    def field_value
      native[:value] || ""
    end

    def form
      first(:ancestors, 'form')
    end

    def valid_for_submission?(button)
      true
    end

  end
end
