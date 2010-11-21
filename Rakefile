require 'bundler'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

RSpec::Core::RakeTask.new(:spec)

task :default => [:features, :spec]

namespace :relish do
  task :push do
    `relish push joefiorini/vimmer`
  end
end
