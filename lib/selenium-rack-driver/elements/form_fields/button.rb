module SeleniumRackDriver
  class Button < FormField

    def valid_for_submission?(button)
      false
    end

  end
end
