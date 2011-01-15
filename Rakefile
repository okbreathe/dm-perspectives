require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "dm-perspectives"
  gem.homepage = "http://github.com/okbreathe/dm-perspectives"
  gem.license = "MIT"
  gem.summary = %Q{Presenters for DataMapper models.}
  gem.description = %Q{Presenters for DataMapper models.}
  gem.email = "asher.vanbrunt@gmail.com"
  gem.authors = ["Asher Van Brunt"]
  gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
  gem.add_development_dependency "yard", ">= 0"
  gem.add_dependency('dm-core', '>= 1.0.0')
  gem.add_dependency('activesupport', '>= 2.3.5')
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "dm-perspectives #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
