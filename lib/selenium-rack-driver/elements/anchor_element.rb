module SeleniumRackDriver
  class AnchorElement < Element

    def click
      href = self[:href]
      browser.process(method, href)
    end

    def valid_for_click?
      self[:href] && !self[:href].start_with?('#')
    end

    private

    def method
      if browser.respect_data_method? && self['data-method']
        self['data-method'].to_sym
      else
        :get
      end
    end

  end
end
