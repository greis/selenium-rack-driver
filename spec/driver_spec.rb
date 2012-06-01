require 'spec_helper'

describe "Driver" do
  it "should get the page title" do
    driver.navigate.to url_with(head: "<title>Test Page</title>")
    driver.title.should == "Test Page"
  end

  it "should get the page source" do
    driver.navigate.to url_with("<html><head><title>Test Page</title></head></html>")
    driver.page_source.should match("<html><head><title>Test Page</title></head></html>")
  end

  # it "should refresh the page" do
  #   driver.navigate.to url_for("javascriptPage.html")
  #   driver.find_element(:link_text, 'Update a div').click
  #   driver.find_element(:id, 'dynamo').text.should == "Fish and chips!"
  #   driver.navigate.refresh
  #   driver.find_element(:id, 'dynamo').text.should == "What's for dinner?"
  # end

  # it "should save a screenshot" do
  #   driver.navigate.to url_for("xhtmlTest.html")
  #   path = "screenshot_tmp.png"

  #   begin
  #     driver.save_screenshot path
  #     File.exist?(path).should be_true # sic
  #     File.size(path).should > 0
  #   ensure
  #     File.delete(path) if File.exist?(path)
  #   end
  # end

  # it "should return a screenshot in the specified format" do
  #   driver.navigate.to url_for("xhtmlTest.html")

  #   ss = driver.screenshot_as(:png)
  #   ss.should be_kind_of(String)
  #   ss.size.should > 0
  # end

  # it "raises an error when given an unknown format" do
  #   lambda { driver.screenshot_as(:jpeg) }.should raise_error(WebDriver::Error::UnsupportedOperationError)
  # end

  describe "execute script" do
    it "should raise an exception" do
      # driver.navigate.to url_for("xhtmlTest.html")
      # driver.execute_script("return document.title;").should == "XHTML Test Page"
    end
  end

  describe "execute async script" do
    # before {
    #   driver.manage.timeouts.script_timeout = 0
    #   driver.navigate.to url_for("ajaxy_page.html")
    # }

    it "should raise an exception" do
      # result = driver.execute_async_script "arguments[arguments.length - 1]([null, 123, 'abc', true, false]);"
      # result.should == [nil, 123, 'abc', true, false]
    end

  end

end

