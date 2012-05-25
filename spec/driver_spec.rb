require 'spec_helper'

describe "Driver" do
  it "should get the page title" do
    driver.navigate.to url_with_content("<html><head><title>Test Page</title></head></html>")
    driver.title.should == "Test Page"
  end

  it "should get the page source" do
    driver.navigate.to url_with_content("<html><head><title>Test Page</title></head></html>")
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

  describe "one element" do
    it "should find by id" do
      driver.navigate.to url_with_content('<div id="id1">Foo</div>', wrap_in_body: true)
      element = driver.find_element(:id, "id1")
      element.should be_kind_of(::Selenium::WebDriver::Element)
      element.text.should == "Foo"
    end

    it "should find by field name" do
      driver.navigate.to url_with_content('<input name="x" value="name" />', wrap_in_body: true)
      driver.find_element(:name, "x").attribute('value').should == "name"
    end

    it "should find by class name" do
      driver.navigate.to url_with_content('<div class="header page">XHTML Might Be The Future</div>')
      driver.find_element(:class, "header").text.should == "XHTML Might Be The Future"
    end

    it "should find by link text" do
      driver.navigate.to url_with_content('<a href="/">Foo</a>')
      driver.find_element(:link, "Foo")[:href].should == "/"
    end

    it "should find by xpath" do
      driver.navigate.to url_with_content('<h1>XHTML Might Be The Future</h1>')
      driver.find_element(:xpath, "//h1").text.should == "XHTML Might Be The Future"
    end

    it "should find by css selector" do
      driver.navigate.to url_with_content('<div class="content">XHTML Might Be The Future</div>')
      driver.find_element(:css, "div.content").attribute("class").should == "content"
    end

    it "should find by tag name" do
      driver.navigate.to url_with_content('<div class="navigation">XHTML Might Be The Future</div>')
      driver.find_element(:tag_name, 'div').attribute("class").should == "navigation"
    end

    it "should find child element" do
      driver.navigate.to url_with_content('<form name="form2"><select id="2" name="selectomatic"></select></form>')

      element = driver.find_element(:name, "form2")
      child   = element.find_element(:name, "selectomatic")

      child.attribute("id").should == "2"
    end

    it "should find child element by tag name" do
      driver.navigate.to url_with_content('<form name="form2"><select id="2" name="selectomatic"></select></form>')

      element = driver.find_element(:name, "form2")
      child   = element.find_element(:tag_name, "select")

      child.attribute("id").should == "2"
    end

    it "should raise on nonexistant element" do
      # driver.navigate.to url_for("xhtmlTest.html")
      # lambda { driver.find_element("nonexistant") }.should raise_error
    end

    it "should find elements with a hash selector" do
      driver.navigate.to url_with_content('<div class="header page">XHTML Might Be The Future</div>')
      driver.find_element(:class => "header").text.should == "XHTML Might Be The Future"
    end

    it "should find elements with the shortcut syntax" do
      driver.navigate.to url_with_content('<h1 id="id1">Foo</h1>', wrap_in_body: true)

      driver[:id1].should be_kind_of(::Selenium::WebDriver::Element)
      driver[:xpath => "//h1"].should be_kind_of(::Selenium::WebDriver::Element)
    end
  end

  describe "many elements" do
    it "should find by class name" do
      driver.navigate.to url_with_content('<div class="nameC">Foo</div><div class="nameC">Bar</div>', wrap_in_body: true)
      driver.find_elements(:class, "nameC").should have(2).things
    end

    it "should find by css selector" do
      driver.navigate.to url_for("xhtmlTest.html")
      driver.find_elements(:css, 'p')
    end

    it "should find children by field name" do
      driver.navigate.to url_with_content('<form name="form2"><select name="selectomatic"></select><select name="selectomatic"></select></form>')
      element = driver.find_element(:name, "form2")
      children = element.find_elements(:name, "selectomatic")
      children.should have(2).items
    end
  end

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

