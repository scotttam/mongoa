require 'rubygems'
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rspec'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mongoa"
    gem.summary = %Q{Like Shoulda but for MongoMapper.}
    gem.description = %Q{Adds the association and validation macros for Rspec in the same way Shoulda does for ActiveRecord.}
    gem.email = "tamosunas@gmail.com"
    gem.homepage = "http://github.com/scotttam/mongoa"
    gem.authors = ["Scott J. Tamosunas"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rcov = false
end

# task :spec => :check_dependencies
task :default => :spec
