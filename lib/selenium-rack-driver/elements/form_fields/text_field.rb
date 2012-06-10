module SeleniumRackDriver
  class TextField < FormField

    def clear
      self[:value] = ""
    end

  end
end
