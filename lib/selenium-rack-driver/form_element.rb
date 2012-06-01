module SeleniumRackDriver
  class FormElement < Element
    def submit
      action = native[:action]
      method = native[:method].to_sym
      params = native.css('input').inject({}) do |hash, node|
        hash.store(node[:name], node[:value])
        hash
      end
      browser.process(method, action, params)
    end
  end
end
