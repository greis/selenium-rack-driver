module SeleniumRackDriver
  class SubmitField < FormField

    def click
      form.submit(self)
    end

    def valid_for_click?
      super && form
    end

    def valid_for_submission?(button)
      super && button == self
    end
  end
end
