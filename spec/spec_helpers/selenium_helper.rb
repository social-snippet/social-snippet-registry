module SeleniumHelper

  require "selenium-webdriver"

  ::RSpec.shared_context :phantomjs_base do
    let(:driver) { ::Selenium::WebDriver.for :phantomjs }
    after { driver.quit }
  end

  ::RSpec.shared_context :phantomjs_1024x768 do
    include_context :phantomjs_base
    before { driver.manage.window.resize_to 1024, 768 }
  end

  ::RSpec.shared_context :firefox_base do
    let(:driver) { ::Selenium::WebDriver.for :firefox }
    after { driver.quit }
  end

  ::RSpec.shared_context :firefox_1024x768 do
    include_context :firefox_base
    before { driver.manage.window.resize_to 1024, 768 }
  end

  ::RSpec.shared_context :firefox_800x600 do
    include_context :firefox_base
    before { driver.manage.window.resize_to 800, 600 }
  end

end
