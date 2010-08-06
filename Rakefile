require 'rubygems'
require 'rake'
# 
# require 'rake/testtask'
# require 'rake/rdoctask'
# 
# require 'rspec'
# require 'rspec/core'

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

# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end
# 
# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
# 
# task :spec => :check_dependencies
# 
# task :default => :spec
# 
# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "mongoa #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
