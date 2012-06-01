require 'spec_helper'

describe "Finders" do

  describe "one element" do
    it "should find by id" do
      driver.navigate.to url_with(body: '<div id="id1">Foo</div>')
      element = driver.find_element(:id, "id1")
      element.should be_kind_of(::Selenium::WebDriver::Element)
      element.text.should == "Foo"
    end

    it "should find by field name" do
      driver.navigate.to url_with(body: '<input name="x" value="name" />')
      driver.find_element(:name, "x").attribute('value').should == "name"
    end

    it "should find by class name" do
      driver.navigate.to url_with(body: '<div class="header page">XHTML Might Be The Future</div>')
      driver.find_element(:class, "header").text.should == "XHTML Might Be The Future"
    end

    it "should find by link text" do
      driver.navigate.to url_with(body: '<a href="/">Foo</a>')
      driver.find_element(:link, "Foo")[:href].should == "/"
    end

    it "should find by xpath" do
      driver.navigate.to url_with(body: '<h1>XHTML Might Be The Future</h1>')
      driver.find_element(:xpath, "//h1").text.should == "XHTML Might Be The Future"
    end

    it "should find by css selector" do
      driver.navigate.to url_with(body: '<div class="content">XHTML Might Be The Future</div>')
      driver.find_element(:css, "div.content").attribute("class").should == "content"
    end

    it "should find by tag name" do
      driver.navigate.to url_with(body: '<div class="navigation">XHTML Might Be The Future</div>')
      driver.find_element(:tag_name, 'div').attribute("class").should == "navigation"
    end

    it "should raise on nonexistant element" do
      # driver.navigate.to url_for("xhtmlTest.html")
      # lambda { driver.find_element("nonexistant") }.should raise_error
    end

    context "child element" do
      it "should find child element" do
        driver.navigate.to url_with(body: '<form name="form2"><select id="2" name="selectomatic"></select></form>')

        element = driver.find_element(:name, "form2")
        child   = element.find_element(:name, "selectomatic")

        child.attribute("id").should == "2"
      end

      it "should find child element by tag name" do
        driver.navigate.to url_with(body: '<form name="form2"><select id="2" name="selectomatic"></select></form>')

        element = driver.find_element(:name, "form2")
        child   = element.find_element(:tag_name, "select")

        child.attribute("id").should == "2"
      end
    end
  end

  describe "many elements" do
    it "should find by class name" do
      driver.navigate.to url_with(body: '<div class="nameC">Foo</div><div class="nameC">Bar</div>')
      driver.find_elements(:class, "nameC").should have(2).things
    end

    it "should find by css selector" do
      driver.navigate.to url_with(body: '<div class="nameC">Foo</div><div class="nameC">Bar</div>')
      driver.find_elements(:css, ".nameC").should have(2).things
    end

    it "should find children by field name" do
      driver.navigate.to url_with(body: '<form name="form2"><select name="selectomatic"></select><select name="selectomatic"></select></form>')
      element = driver.find_element(:name, "form2")
      children = element.find_elements(:name, "selectomatic")
      children.should have(2).items
    end
  end

end

