module SeleniumRackDriver
  class FormElement < Element

    def multipart?
      self[:enctype] == "multipart/form-data"
    end

    def submit(button = nil)
      action = native[:action]
      method = native[:method].to_sym
      params = {}

      find(:xpath, '(.//input|.//textarea|.//select)').each do |element|
        merge_param!(params, element.field_name, element.field_value) if element.valid_for_submission?(button)
      end

      browser.process(method, action, params)
    end

    private

    def merge_param!(params, key, value)
      Rack::Utils.normalize_params(params, key, value) unless value.nil?
    end

  end
end
