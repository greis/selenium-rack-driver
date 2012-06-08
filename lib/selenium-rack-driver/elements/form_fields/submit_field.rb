module SeleniumRackDriver
  class SubmitField < FormField

    def click
      form.submit(self)
    end

    def valid_for_submission?(button)
      button == self
    end
  end
end
