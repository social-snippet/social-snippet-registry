require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:mongoid)
PadrinoTasks.init

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = [
      "--format doc",
      "--color",
    ]
  end

  RSpec::Core::RakeTask.new(:spec_current) do |t|
    t.rspec_opts = [
      "--format doc",
      "--color",
      "--tag current",
    ]
  end

rescue LoadError
  # for heroku
end

