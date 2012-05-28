module SeleniumRackDriver
  class Browser
    include ::Rack::Test::Methods

    attr_accessor :current_host

    def app
      SeleniumRackDriver.app
    end

    def dom
      @dom ||= SeleniumRackDriver::Element.for(Nokogiri::HTML(source))
    end

    def process(method, path, attributes = {}, env = {})
      reset_cache!
      send(method, path, attributes, env)
    end

    def reset_cache!
      @dom = nil
    end

    def source
      last_response.body
    rescue Rack::Test::Error
      ""
    end

  end
end
