require "bundler/gem_tasks"
require 'rspec/core/rake_task'

desc "Run an IRB session with Momm preloaded"
task :console do
  exec "irb -I lib -r momm"
end

desc "Run the test suite"
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = %w|--color|
end

task default: :spec

