require 'rake/testtask'
require 'rake/release'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = true
end
