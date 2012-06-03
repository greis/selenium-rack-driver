module SeleniumRackDriver
  class FormElement < Element

    def submit
      action = native[:action]
      method = native[:method].to_sym
      params = {}

      find(:xpath, '(.//input|.//textarea|.//select)').each do |element|
        merge_param!(params, element.field_name, element.field_value)
      end

      browser.process(method, action, params)
    end

    private

    def merge_param!(params, key, value)
      Rack::Utils.normalize_params(params, key, value) if value
    end

  end
end
