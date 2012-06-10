require 'spec_helper'

describe "click action" do

  before do
    driver.navigate.to url_with(body: body)
    driver.find_element(:css, clickable).click
  end

  context "input" do

    let(:clickable) { "input" }

    %w(submit image).each do |type|
      context "type #{type}" do
        context "inside a form" do
          let(:body) do
            <<-BODY
            <form method="post" action="/display_params">
              <input type="#{type}" name="color" value="red" />
            </form>
            BODY
          end

          it "sends input params" do
            driver.page_source.should include('color=red')
          end
        end

        context "outside a form" do
          let(:body) do
            <<-BODY
              <form method="post" action="/display_params"></form>
              <input type="#{type}" name="color" value="red" />
            BODY
          end

          it "does not submit the form" do
            URI(driver.current_url).path.should == "/"
          end

        end
      end
    end

    %w(reset button).each do |type|
      context "type #{type}" do
        let(:body) do
          <<-BODY
          <form method="post" action="/display_params">
            <input type="#{type}" name="color" value="red" />
          </form>
          BODY
        end

        it "does not submit the form" do
          URI(driver.current_url).path.should == "/"
        end
      end
    end
  end
  context "button"
  context "anchor"
end

