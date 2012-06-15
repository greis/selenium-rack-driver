module SeleniumRackDriver
  class AnchorElement < Element

    def click
      href = self[:href]
      browser.process(:get, href)
    end

    def valid_for_click?
      self[:href] && !self[:href].start_with?('#')
    end

  end
end
