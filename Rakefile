require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "imap_model"
    gem.summary = %Q{An ActiveModel-based IMAP implementation}
    gem.description = %Q{An ActiveModel-based IMAP implementation for use in Rails applications.}
    gem.email = "jolohaga@me.com"
    gem.homepage = "http://github.com/jolohaga/imap_model"
    gem.authors = ["Jose Hales-Garcia"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

#require 'rspec/rake/spectask'
#RSpec::Rake::SpecTask.new(:spec) do |spec|
#  spec.libs << 'lib' << 'spec'
#  spec.spec_files = FileList['spec/**/*_spec.rb']
#end
#
#RSpec::Rake::SpecTask.new(:rcov) do |spec|
#  spec.libs << 'lib' << 'spec'
#  spec.pattern = 'spec/**/*_spec.rb'
#  spec.rcov = true
#end
#
task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "imap_model #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
