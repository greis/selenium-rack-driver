module SeleniumRackDriver
  class SelectElement < Element

    def field_name
      native[:name]
    end

    def field_value
      option = native.at_xpath('.//option[@selected]') || native.at_xpath('.//option')
      option[:value]
    end

  end
end
