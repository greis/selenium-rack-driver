module SeleniumRackDriver
  class Browser
    include ::Rack::Test::Methods

    attr_accessor :current_url

    def app
      SeleniumRackDriver.app
    end

    def dom
      @dom ||= SeleniumRackDriver::Element.for(Nokogiri::HTML(source), self)
    end

    def process(method, path, attributes = {}, env = {})
      self.current_url = path
      reset_cache!
      send(method, path, attributes, env)
    end

    def reset_cache!
      @dom = nil
    end

    def respect_data_method?
      SeleniumRackDriver.respect_data_method
    end

    def source
      last_response.body
    rescue Rack::Test::Error
      ""
    end

  end
end
