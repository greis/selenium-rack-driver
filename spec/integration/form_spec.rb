require 'spec_helper'

describe "Form" do

  describe "submit" do

    context "when form method is POST" do

      before do
        body = <<-BODY
          <form method="post" action="/display_params">
            #{input}
          </form>
        BODY
        driver.navigate.to url_with(body: body)
        driver.find_element(:tag_name, 'form').submit
      end

      context "and input field is text" do
        let(:input) { %(<input type="text" name="color" value="red" />) }

        it "sends input text params" do
          driver.page_source.should include('color=red')
        end
      end

      context "and input field is textarea" do
        let(:input) { %(<textarea name="color">red</textarea>) }

        it "sends input text params" do
          driver.page_source.should include('color=red')
        end
      end
      context "and input field is radio button"
      context "and input field is checkbox"
      context "and input field is select box"
      context "and input field is file"
      context "and input field is submit"
      context "and input field is image"
    end
  end

end
