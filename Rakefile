require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/identificamex'
  t.test_files = FileList['test/identificamex/*_test.rb']
end

task :default => :test
