require 'spec_helper'

describe "Form" do

  describe "submit" do

    context "POST method" do

      it "sends input text params" do
        body = <<-BODY
          <form method="post" action="/display_params">
            <input type="text" name="color" value="red" />
          </form>
        BODY
        driver.navigate.to url_with(body: body)
        driver.find_element(:tag_name, 'form').submit
        driver.page_source.should include('color=red')
      end
    end
  end

end
