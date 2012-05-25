module SeleniumRackDriver
  class Browser
    include ::Rack::Test::Methods

    attr_accessor :current_host

    def app
      SeleniumRackDriver.app
    end

    def dom
      @dom ||= Nokogiri::HTML(source)
    end

    def process(method, path, attributes = {}, env = {})
      # new_uri = URI.parse(path)
      # method.downcase! unless method.is_a? Symbol

      # if new_uri.host
      #   @current_host = "#{new_uri.scheme}://#{new_uri.host}"
      #   @current_host << ":#{new_uri.port}" if new_uri.port != new_uri.default_port
      # end

      # if new_uri.relative?
      #   if path.start_with?('?')
      #     path = request_path + path
      #   elsif not path.start_with?('/')
      #     path = request_path.sub(%r(/[^/]*$), '/') + path
      #   end
      #   path = current_host + path
      # end

      reset_cache!
      # send(method, path, attributes, env.merge(options[:headers] || {}))
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
