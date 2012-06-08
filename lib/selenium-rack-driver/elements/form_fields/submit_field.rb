module SeleniumRackDriver
  class SubmitField < FormField

    def valid_for_submission?
      false
    end
  end
end
