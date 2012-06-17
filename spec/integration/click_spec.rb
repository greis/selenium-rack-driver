require 'spec_helper'

describe "click action" do

  let(:respect_data_method) { true }

  before do
    SeleniumRackDriver.respect_data_method = respect_data_method
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

  context "button" do
    let(:clickable) { "button" }

    %w(submit unknown).each do |type|
      context "type #{type}" do
        context "inside a form" do
          let(:body) do
            <<-BODY
            <form method="post" action="/display_params">
              <button type="#{type}" name="color" value="red" />
            </form>
            BODY
          end

          it "sends the param" do
            driver.page_source.should include('color=red')
          end
        end

        context "outside a form" do
          let(:body) do
            <<-BODY
              <form method="post" action="/display_params"></form>
              <button type="#{type}" name="color" value="red" />
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
            <button type="#{type}" name="color" value="red" />
          </form>
          BODY
        end

        it "does not submit the form" do
          URI(driver.current_url).path.should == "/"
        end
      end
    end
  end

  context "anchor" do
    let(:clickable) { "a" }

    context "href without params" do
      let(:body) { %(<a href="/result.html">Go</a>) }
      it "should go to another page" do
        URI(driver.current_url).path.should == "/result.html"
      end
    end

    context "href with params" do
      let(:body) { %(<a href="/result.html?title=Hello">Go</a>) }
      it "should go to another page" do
        URI(driver.current_url).path.should == "/result.html"
      end

      it "should send the params to the other page" do
        driver.title.should == "Hello"
      end
    end

    context "no href attribute" do
      let(:body) { %(<a>Go</a>) }
      it "should not go to another page" do
        URI(driver.current_url).path.should == "/"
      end
    end

    context "with internal href attribute" do
      let(:body) { %(<a href="#123">Go</a>) }
      it "should not go to another page" do
        URI(driver.current_url).path.should == "/"
      end
    end

    context "with data-method attribute" do
      context "respect_data_method to true" do
        let(:body) { %(<a href="/display_params?color=red" data-method="post">Go</a>) }
        it "should send a POST request" do
          URI(driver.current_url).path.should == "/display_params"
          driver.page_source.should include("color=red")
        end
      end

      context "respect_data_method to false" do
        let(:respect_data_method) { false }
        let(:body) { %(<a href="/result.html?title=Hello" data-method="post">Go</a>) }
        it "should send a GET request" do
          URI(driver.current_url).path.should == "/result.html"
          driver.title.should == "Hello"
        end
      end
    end
  end

  context "select" do

    context "single option" do

      let(:body) { %(<select name="color">#{options}</select>) }

      context "no option is selected" do
        let(:options) do
          <<-OPTIONS
          <option value="green">Green</option>
          <option value="red">Red</option>
          OPTIONS
        end
        let(:clickable) { "option[value=red]" }

        it "should set the option as selected" do
          driver.find_element(:css, "option[value=red]").should be_selected
        end

        it "should keep the other option as unselected" do
          driver.find_element(:css, "option[value=green]").should_not be_selected
        end
      end

      context "another option is already selected" do
        let(:options) do
          <<-OPTIONS
          <option value="green" selected>Green</option>
          <option value="red">Red</option>
          OPTIONS
        end
        let(:clickable) { "option[value=red]" }

        it "should set the option as selected" do
          driver.find_element(:css, "option[value=red]").should be_selected
        end

        it "should unselect the other option" do
          driver.find_element(:css, "option[value=green]").should_not be_selected
        end
      end
    end

    context "multiple options" do

      let(:body) { %(<select name="color" multiple>#{options}</select>) }

      context "no option is selected" do
        let(:options) do
          <<-OPTIONS
          <option value="green">Green</option>
          <option value="red">Red</option>
          OPTIONS
        end
        let(:clickable) { "option[value=red]" }

        it "should set the option as selected" do
          driver.find_element(:css, "option[value=red]").should be_selected
        end

        it "should keep the other option as unselected" do
          driver.find_element(:css, "option[value=green]").should_not be_selected
        end
      end

      context "another option is already selected" do
        let(:options) do
          <<-OPTIONS
          <option value="green" selected>Green</option>
          <option value="blue" selected>Blue</option>
          <option value="red">Red</option>
          OPTIONS
        end

        context "clicking the unselected option" do
          let(:clickable) { "option[value=red]" }

          it "should set the option as selected" do
            driver.find_element(:css, "option[value=red]").should be_selected
          end

          it "should not change the other options" do
            driver.find_element(:css, "option[value=green]").should be_selected
            driver.find_element(:css, "option[value=blue]").should be_selected
          end
        end

        context "clicking the selected option" do
          let(:clickable) { "option[value=green]" }

          it "should set the unselect the option" do
            driver.find_element(:css, "option[value=green]").should_not be_selected
          end

          it "should not change the other options" do
            driver.find_element(:css, "option[value=red]").should_not be_selected
            driver.find_element(:css, "option[value=blue]").should be_selected
          end
        end
      end
    end
  end
end

