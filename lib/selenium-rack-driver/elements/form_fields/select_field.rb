module SeleniumRackDriver
  class SelectField < FormField

    def field_value
      if multiple?
        selected_options.map(&:field_value)
      else
        option = selected_options.first || options.first
        option.field_value
      end
    end

    private

    def multiple?
      native[:multiple]
    end

    def options
      find(:xpath, './/option')
    end

    def selected_options
      options.select{|o| o[:selected] }
    end

  end
end
