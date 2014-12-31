require "bundler/setup"

require_relative "spec_helpers/rack_helper"
require_relative "spec_helpers/database_cleaner_helper"
require_relative "spec_helpers/factory_girl_helper"
require_relative "spec_helpers/selenium_helper"

# Padrino Apps
RACK_ENV = 'test' unless defined?(RACK_ENV)
require_relative "../config/boot"

require "social_snippet/registry_core"
