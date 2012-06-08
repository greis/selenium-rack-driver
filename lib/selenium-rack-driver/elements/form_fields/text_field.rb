module SeleniumRackDriver
  class TextField < FormField

    def clear
      native[:value] = ""
    end

  end
end
