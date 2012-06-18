require 'spec_helper'

describe "Form" do

  describe "submit" do

    before do
      driver.navigate.to url_with(body: body)
      driver.find_element(:tag_name, 'form').submit
    end

    context "when no action is provided" do
      let(:body) do
        <<-BODY
          <form>
            <input type="text" name="content" value="Hello" />
          </form>
        BODY
      end

      it "should submit to the current url" do
        driver.current_url.should == "/"
      end

      it "should submit the params" do
        driver.page_source.should == "Hello"
      end
    end

    context "when action is empty" do
      let(:body) do
        <<-BODY
          <form action="">
            <input type="text" name="content" value="Hello" />
          </form>
        BODY
      end

      it "should submit to the current url" do
        driver.current_url.should == "/"
      end

      it "should submit the params" do
        driver.page_source.should == "Hello"
      end
    end

    context "when form method is POST" do

      let(:body) do
        <<-BODY
          <form method="post" action="/display_params">
            #{input}
          </form>
        BODY
      end

      context "empty params" do
        let(:input) { "" }
        it "should make a POST request" do
          driver.page_source.should include('[method: post]')
        end
      end

      context "disabled fields" do
        let(:input) do
          <<-INPUT
            <input type="text" name="content" value="Hello"/>
            <textarea name="color" disabled>red</textarea>
            <input type="radio" name="color" value="red" checked disabled/>
            <input type="checkbox" name="color" value="red" checked disabled/>
            <input type="file" name="color" value="spec/data/red.jpg" disabled/>
            <select name="color" disabled>
              <option value="red" selected>Red</option>
            </select>
            <input type="text" name="color" value="red" disabled/>
          INPUT
        end

        it "should not send the disabled param" do
          driver.page_source.should_not include('color')
        end

        it "should send the enabled param" do
          driver.page_source.should include('content')
        end
      end

      %w(text password hidden).each do |type|
        context "and input field is #{type}" do
          context "with value" do
            let(:input) { %(<input type="#{type}" name="color" value="red" />) }

            it "sends input #{type} param" do
              driver.page_source.should include('color=red')
            end
          end

          context "without value" do
            let(:input) { %(<input type="#{type}" name="color" />) }

            it "sends empty input #{type} param" do
              driver.page_source.should include('color=')
            end
          end
        end
      end

      context "and input with no type" do
        let(:input) { %(<input name="color" value="red" />) }

        it "sends as a text param" do
          driver.page_source.should include('color=red')
        end
      end

      context "and unknown input type" do
        let(:input) { %(<input type="xyz" name="color" value="red" />) }

        it "sends as a text param" do
          driver.page_source.should include('color=red')
        end
      end

      context "and input field is textarea" do
        context "with content" do
          let(:input) { %(<textarea name="color">red</textarea>) }

          it "sends textarea param" do
            driver.page_source.should include('color=red')
          end
        end

        context "without content" do
          let(:input) { %(<textarea name="color"></textarea>) }

          it "sends textarea param" do
            driver.page_source.should include('color=')
          end
        end
      end

      context "and input field is select box" do

        context "single option" do
          let(:input) { %(<select name="color">#{options}</select>) }

          context "no option is selected" do
            let(:options) do
              <<-OPTIONS
                <option value="red">Red</option>
                <option value="green">Green</option>
              OPTIONS
            end

            it "sends the first option value params" do
              driver.page_source.should include('color=red')
            end

            it "does not send other options" do
              driver.page_source.should_not include('green')
            end
          end

          context "last option is selected" do
            let(:options) do
              <<-OPTIONS
                <option value="red">Red</option>
                <option value="green" selected>Green</option>
              OPTIONS
            end

            it "sends the selected option value params" do
              driver.page_source.should include('color=green')
            end

            it "does not send other options" do
              driver.page_source.should_not include('red')
            end
          end

          context "option with no value" do
            let(:options) do
              <<-OPTIONS
                <option>Red</option>
              OPTIONS
            end

            it "sends the options's text as a param" do
              driver.page_source.should include('color=Red')
            end

          end
        end

        context "multiple options" do
          let(:input) {%(<select name="color[]" multiple>#{options}</select>)}

          context "one option is selected" do
            let(:options) do
              <<-OPTIONS
                <option value="red">Red</option>
                <option value="green" selected>Green</option>
              OPTIONS
            end

            it "sends the selected option value params" do
              driver.page_source.should include('color=green')
            end

            it "does not send unselected options" do
              driver.page_source.should_not include('red')
            end
          end

          context "multiple options selected" do
            let(:options) do
              <<-OPTIONS
                <option value="red" selected>Red</option>
                <option value="green" selected>Green</option>
                <option value="blue">Blue</option>
              OPTIONS
            end

            it "sends the selected options value params" do
              driver.page_source.should include('color=red,green')
            end

            it "does not send unselected options" do
              driver.page_source.should_not include('blue')
            end

          end

          context "no option is selected" do
            let(:options) do
              <<-OPTIONS
                <option value="red">Red</option>
              OPTIONS
            end

            it "doest not send the option value params" do
              driver.page_source.should_not include('color')
            end
          end

          context "options with no value" do
            let(:options) do
              <<-OPTIONS
                <option selected>Red</option>
                <option selected>Green</option>
                <option>Blue</option>
              OPTIONS
            end

            it "sends the selected options text params" do
              driver.page_source.should include('color=Red,Green')
            end

            it "does not send unselected options" do
              driver.page_source.should_not include('Blue')
            end
          end
        end

      end

      context "and input field is checkbox" do
        context "with one checked box" do
          let(:input) do
            <<-INPUT
              <input type="checkbox" name="color[]" value="red" checked/>
              <input type="checkbox" name="color[]" value="green" />
            INPUT
          end

          it "sends the checked box param" do
            driver.page_source.should include('color=red')
          end

          it "does not send unchecked box" do
            driver.page_source.should_not include('green')
          end
        end

        context "with mutiple checked boxes" do
          let(:input) do
            <<-INPUT
              <input type="checkbox" name="color[]" value="red" checked/>
              <input type="checkbox" name="color[]" value="green" checked/>
              <input type="checkbox" name="color[]" value="blue"/>
            INPUT
          end

          it "sends the checked box param" do
            driver.page_source.should include('color=red,green')
          end

          it "does not send unchecked box" do
            driver.page_source.should_not include('blue')
          end
        end

        context "with no checked box" do
          let(:input) do
            <<-INPUT
              <input type="checkbox" name="color[]" value="red"/>
            INPUT
          end

          it "does not send color param" do
            driver.page_source.should_not include('color')
          end
        end
      end

      context "and input field is radio button" do
        context "with checked radio" do
          let(:input) do
            <<-INPUT
              <input type="radio" name="color" value="red" checked/>
              <input type="radio" name="color" value="green" />
            INPUT
          end

          it "sends the checked radio param" do
            driver.page_source.should include('color=red')
          end

          it "does not send unchecked radio" do
            driver.page_source.should_not include('green')
          end
        end

        context "with no checked radio" do
          let(:input) do
            <<-INPUT
              <input type="radio" name="color" value="red"/>
            INPUT
          end

          it "does not send color param" do
            driver.page_source.should_not include('color')
          end
        end
      end

      context "and input field is file" do
        context "with default content type" do
          let(:input) do
            <<-INPUT
              <input type="file" name="color" value="spec/data/red.jpg"/>
            INPUT
          end

          it "sends the file's base name as a param" do
            driver.page_source.should include('color=red.jpg')
          end
        end

        context "with multipart content type" do
          let(:body) do
            <<-BODY
            <form method="post" enctype="multipart/form-data" action="/display_params">
              #{input}
            </form>
            BODY
          end

          context "and file is set" do
            let(:input) { %(<input type="file" name="color" value="spec/data/red.jpg"/>) }

            it "sends the file as a param" do
              driver.page_source.should include('color={:filename=>"red.jpg", :type=>"image/jpeg"')
            end
          end

          context "and file is not set" do
            let(:input) { %(<input type="file" name="color"/>) }

            it "does not send the param" do
              driver.page_source.should_not include('color')
            end
          end
        end
      end

      %w(submit image reset button).each do |type|
        context "and input field is #{type}" do
          let(:input) { %(<input type="#{type}" name="color" value="red" />) }

          it "does not send param" do
            driver.page_source.should_not include('color')
          end
        end
      end

      %w(reset button submit unknown).each do |type|
        context "and button type is #{type}" do
          let(:input) { %(<button type="#{type}" name="color" value="red" />) }

          it "does not send param" do
            driver.page_source.should_not include('color')
          end
        end
      end

      context "multiple fields" do
        let(:input) do
          <<-INPUT
            <input type="text" name="color" value="red" />
            <input type="hidden" name="size" value="1" />
          INPUT
        end

        it "sends the params" do
          driver.page_source.should include("color=red", "size=1")
        end

      end
    end

    context "when form method is GET" do
      let(:body) do
        <<-BODY
          <form method="get" action="/display_params">
            <input type="text" name="color" value="red" />
          </form>
        BODY
      end

      it "should make a GET request" do
        driver.page_source.should include('[method: get]')
      end

      it "should send the param" do
        driver.page_source.should include("color=red")
      end
    end

    context "when form method is not GET or POST" do
      let(:body) do
        <<-BODY
          <form method="delete" action="/display_params">
            <input type="text" name="color" value="red" />
          </form>
        BODY
      end

      it "should make a GET request" do
        driver.page_source.should include('[method: get]')
      end

      it "should send the param" do
        driver.page_source.should include("color=red")
      end
    end
  end

end
