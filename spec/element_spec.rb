require File.expand_path("../spec_helper", __FILE__)

describe "Element" do

  context "get attributes" do
    it "should get attribute value" do
      content = <<-CONTENT
        <textarea id="withText" rows="5" cols="5">Example text</textarea>
      CONTENT
      driver.navigate.to url_with(body: content)
      driver.find_element(:id, "withText").attribute("rows").should == "5"
    end

    it "should return nil for non-existent attributes" do
      content = <<-CONTENT
        <textarea id="withText" rows="5" cols="5">Example text</textarea>
      CONTENT
      driver.navigate.to url_with(body: content)
      driver.find_element(:id, "withText").attribute("nonexistent").should be_nil
    end
  end

  context "clear text" do
    it "should clear textarea" do
      content = <<-CONTENT
        <textarea id="withText" rows="5" cols="5">Example text</textarea>
      CONTENT
      driver.navigate.to url_with(body: content)
      driver.find_element(:id, "withText").clear
      driver.find_element(:id, "withText").text.should == ""
    end

    it "should clear input[text]" do
      content = <<-CONTENT
        <input type="text" value="Example input text" id="withText">
      CONTENT
      driver.navigate.to url_with(body: content)
      driver.find_element(:id, "withText").clear
      driver.find_element(:id, "withText")[:value].should == ""
    end

    it "should not clear non text fields" do
      content = <<-CONTENT
        <input type="hidden" value="Example input text" id="withText">
      CONTENT
      driver.navigate.to url_with(body: content)
      driver.find_element(:id, "withText").clear
      driver.find_element(:id, "withText")[:value].should == "Example input text"
    end
  end

  context "enabled" do
    it "should get enabled" do
      content = <<-CONTENT
        <input type="text" id="notWorking" disabled="true"/>
      CONTENT
      driver.navigate.to url_with(body: content)
      driver.find_element(:id, "notWorking").should_not be_enabled
    end
  end

  context "compare elements" do
    it "should know when two elements are equal" do
      content = <<-CONTENT
        <p></p>
      CONTENT
      driver.navigate.to url_with(body: content)

      body  = driver.find_element(:tag_name, 'body')
      xbody = driver.find_element(:xpath, "//body")

      body.should == xbody
      body.should eql(xbody)
    end

    it "should know when two elements are not equal" do
      content = <<-CONTENT
        <p></p>
        <p></p>
      CONTENT
      driver.navigate.to url_with(body: content)

      elements = driver.find_elements(:tag_name, 'p')
      p1 = elements.fetch(0)
      p2 = elements.fetch(1)

      p1.should_not == p2
      p1.should_not eql(p2)
    end

    it "should return the same #hash for equal elements when found by Driver#find_element" do
      content = <<-CONTENT
        <p></p>
      CONTENT
      driver.navigate.to url_with(body: content)

      body  = driver.find_element(:tag_name, 'body')
      xbody = driver.find_element(:xpath, "//body")

      body.hash.should == xbody.hash
    end

    it "should return the same #hash for equal elements when found by Driver#find_elements" do
      content = <<-CONTENT
        <p></p>
      CONTENT
      driver.navigate.to url_with(body: content)

      body  = driver.find_elements(:tag_name, 'body').fetch(0)
      xbody = driver.find_elements(:xpath, "//body").fetch(0)

      body.hash.should == xbody.hash
    end
  end
end
