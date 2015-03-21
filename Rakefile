require 'bundler/gem_tasks'
require 'rake'
require 'rspec/core/rake_task'

task :default => :spec

desc 'Run all examples'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/**/*_spec.rb'
end
