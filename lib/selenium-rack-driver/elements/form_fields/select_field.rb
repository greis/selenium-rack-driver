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

    def select_option(option)
      if multiple?
        option.selected? ? option.unselect : option.select
      else
        selected_options.each(&:unselect)
        option.select
      end
    end

    private

    def multiple?
      self[:multiple]
    end

    def options
      find(:xpath, './/option')
    end

    def selected_options
      options.select(&:selected?)
    end

  end
end
