require 'spec_helper'

describe "Form" do

  describe "submit" do

    context "when form method is POST" do

      let(:body) do
        <<-BODY
          <form method="post" action="/display_params">
            #{input}
          </form>
        BODY
      end

      before do
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

      context "and input field is hidden" do
        context "with value" do
          let(:input) { %(<input type="hidden" name="color" value="red" />) }

          it "sends input hidden param" do
            driver.page_source.should include('color=red')
          end
        end

        context "without value" do
          let(:input) { %(<input type="hidden" name="color" />) }

          it "sends empty input hidden param" do
            driver.page_source.should include('color=')
          end
        end
      end

      context "and input field is password" do
        context "with value" do
          let(:input) { %(<input type="password" name="color" value="red" />) }

          it "sends input password param" do
            driver.page_source.should include('color=red')
          end
        end

        context "without value" do
          let(:input) { %(<input type="password" name="color" />) }

          it "sends empty input password param" do
            driver.page_source.should include('color=')
          end
        end
      end

      context "and input field is submit" do
        let(:input) { %(<input type="submit" name="color" value="red" />) }

        it "does not send param" do
          driver.page_source.should_not include('color')
        end
      end

      context "and input field is image" do
        let(:input) { %(<input type="image" name="color" value="red" />) }

        it "does not send param" do
          driver.page_source.should_not include('color')
        end
      end
    end
  end

end
