module SeleniumRackDriver
  class SelectElement < Element

    def field_name
      native[:name]
    end

    def field_value
      option = selected_options.first || options.first
      option.field_value
    end

    private

    def options
      find(:xpath, './/option')
    end

    def selected_options
      options.select{|o| o[:selected] }
    end

  end
end
