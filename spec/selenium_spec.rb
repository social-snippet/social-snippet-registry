require "spec_helper"

describe "Selenium" do

  shared_context :open_home do

    context "open home" do

      before { driver.navigate.to "http://localhost:19292" }
      it { expect(driver.current_url).to eq "http://localhost:19292/" }

      context "search repo" do

        let(:input_element) do
          wait = ::Selenium::WebDriver::Wait.new(:timeout => 10)
          wait.until { driver.find_element(:name => "q", :class => "query").displayed? }
          driver.find_element :name => "q", :class => "query"
        end

        before do
          input_element.send_keys "repo"
          input_element.submit
        end

        it { expect(driver.current_url).to eq "http://localhost:19292/search?q=repo" }

      end

    end

  end

  describe "phantomjs" do
    include_context :phantomjs_1024x768
    include_context :open_home
  end

  describe "firefox" do
    include_context :firefox_1024x768
    include_context :open_home
  end

end
