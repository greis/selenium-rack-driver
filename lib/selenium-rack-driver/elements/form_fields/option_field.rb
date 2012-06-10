module SeleniumRackDriver
  class OptionField < FormField

    def field_value
      self[:value] || content
    end

  end
end
