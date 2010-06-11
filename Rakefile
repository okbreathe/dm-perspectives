require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "dm-perspectives"
    gem.summary = %Q{Presenters for DataMapper models.}
    gem.description = %Q{Presenters for DataMapper models.}
    gem.email = "asher@okbreathe.com"
    gem.homepage = "http://github.com/okbreathe/dm-perspectives"
    gem.authors = ["Asher Van Brunt"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency('dm-core', '>= 1.0.0')
    gem.add_dependency('activesupport', '>= 2.3.5')
    gem.add_dependency('facets', '>= 2.8.4')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
