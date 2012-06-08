module SeleniumRackDriver
  class FormField < Element

    def field_name
      native[:name]
    end

    def field_value
      native[:value] || ""
    end

    def valid_for_submission?
      true
    end

  end
end
