# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'reek/rake/task'
require 'cucumber/rake/task'

namespace :quality do
  Reek::Rake::Task.new do |t|
    t.fail_on_error = true
    t.verbose = false
  end

  RuboCop::RakeTask.new do |t|
    t.options << '--display-cop-names'
  end

  task all: [:rubocop, :reek]
end

namespace :test do
  RSpec::Core::RakeTask.new(:spec)

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = 'features --format progress --color'
  end

  task :mutant do
    command = <<-EOS
      RUBY_THREAD_VM_STACK_SIZE=64000\
      bundle exec mutant\
        --include lib\
        --require balboa\
        --use rspec\
        --since master^\
        --jobs 4 'Balboa*'
    EOS
    system command
    abort unless $CHILD_STATUS.success?
  end

  task all: ['test:spec', 'test:features', :mutant]
end

task ci: ['test:all', 'quality:all']

task default: :ci
