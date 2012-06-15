module SeleniumRackDriver
  class FormElement < Element

    def multipart?
      self[:enctype] == "multipart/form-data"
    end

    def submit(button = nil)
      params = {}

      find(:xpath, '(.//input|.//textarea|.//select|.//button)').each do |element|
        merge_param!(params, element.field_name, element.field_value) if element.valid_for_submission?(button)
      end

      browser.process(method, action, params)
    end

    private

    def action
      action = self[:action]
      action = browser.current_path if action.nil? || action.empty?
      action
    end

    def merge_param!(params, key, value)
      Rack::Utils.normalize_params(params, key, value)
    end

    def method
      self[:method] =~ /post/i ? :post : :get
    end

  end
end
