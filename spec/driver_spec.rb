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
end
