module SeleniumRackDriver
  class FormElement < Element

    def submit
      action = native[:action]
      method = native[:method].to_sym

      params = find(:xpath, '(.//input|.//textarea|.//select)').inject({}) do |params, element|
        merge_param!(params, element.field_name, element.field_value) if element.field_value
        params
      end
      browser.process(method, action, params)
    end

    private

    def merge_param!(params, key, value)
      Rack::Utils.normalize_params(params, key, value)
    end

  end
end
