module SeleniumRackDriver
  class FormElement < Element

    def submit
      action = native[:action]
      method = native[:method].to_sym

      params = find(:xpath, '(.//input|.//textarea|.//select)').inject({}) do |hash, element|
        hash.store(element.field_name, element.field_value)
        hash
      end
      browser.process(method, action, params)
    end

  end
end
