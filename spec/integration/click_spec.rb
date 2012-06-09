require 'spec_helper'

describe "click action" do

  context "input type submit" do

    before do
      driver.navigate.to url_with(body: body)
      driver.find_element(:css, 'input[type="submit"]').click
    end

    context "inside a form" do
      let(:body) do
        <<-BODY
        <form method="post" action="/display_params">
          #{input}
        </form>
        BODY
      end

      let(:input) { %(<input type="submit" name="color" value="red" />) }

      it "sends input submit params" do
        driver.page_source.should include('color=red')
      end
    end

    context "outside a form" do
      let(:body) do
        <<-BODY
        <form method="post" action="/display_params">
        </form>
        <input type="submit" name="color" value="red" />
        BODY
      end

      it "does not submit the form" do
        URI(driver.current_url).path.should == "/"
      end

    end
  end
  context "input type image"
  context "button"
  context "anchor"
end

