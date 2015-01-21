require "spec_helper"

describe "Selenium" do

  shared_context :open_home do

    context "open home" do

      before { driver.navigate.to "http://localhost:19292" }
      it { expect(driver.current_url).to eq "http://localhost:19292/" }

      context "search repo" do

        let(:input_query) do
          wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
          wait.until { driver.find_element :name => "q", :css => "input.query" }
        end

        before do
          input_query.send_keys "repo"
          input_query.submit
        end

        it { expect(driver.current_url).to eq "http://localhost:19292/search?q=repo" }

        context "result panels" do
          let(:panels) do
            wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
            wait.until { driver.find_elements :css => ".contents-region .panel" }
          end
          it { expect(panels).to be_empty }
        end

        context "click add link" do

          let(:link_element) do
            wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
            wait.until { driver.find_element :css => 'a[href="/new/repository"]' }
          end

          before { link_element.click }
          it { expect(driver.current_url).to eq "http://localhost:19292/new/repository" }

        end # click add link

      end # search repo

      context "click add link" do

        let(:link_element) do
          wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
          wait.until { driver.find_element :css => 'a[href="/new/repository"]' }
        end

        before { link_element.click }
        it { expect(driver.current_url).to eq "http://localhost:19292/new/repository" }

        context "input github repo info" do

          let(:input_user_name) do
            wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
            wait.until { driver.find_element :css => ".by-github-region input.new-repo-user" }
          end

          before { input_user_name.send_keys "social-snippet" }

          let(:input_repo_name) do
            wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
            wait.until { driver.find_element :css => ".by-github-region input.new-repo-name" }
          end

          before { input_repo_name.send_keys "example-repo" }

          it { expect(input_user_name.attribute "value").to eq "social-snippet" }
          it { expect(input_repo_name.attribute "value").to eq "example-repo" }

          context "click add button" do

            let(:add_button) do
              wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
              wait.until { driver.find_element :css => ".by-github-region .btn.add" }
            end

            before { add_button.click }

            it { expect(add_button.text).to eq "Doing..." }

            context "show repo page" do

              before do
                wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
                wait.until { driver.current_url === "http://localhost:19292/repositories/example-repo" }
              end

              it { expect(driver.current_url).to eq "http://localhost:19292/repositories/example-repo" }

            end

          end

        end

      end # click add link

    end # open home

  end # :open_home

  describe "phantomjs" do
    include_context :phantomjs_1024x768
    include_context :open_home
  end

  describe "firefox" do
    include_context :firefox_1024x768
    include_context :open_home
  end

end # Selenium
