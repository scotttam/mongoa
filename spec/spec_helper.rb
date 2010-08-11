# $LOAD_PATH.unshift(File.dirname(__FILE__))
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'mongo_mapper'
require 'mongo_mapper/plugins'
require 'mongo_mapper/plugins/associations'

config = {
    'test' => {'host' => 'localhost', 'port' => 27017, 'database' => 'mongoa_test'},
}

MongoMapper.config = config
MongoMapper.connect("test")

require 'rspec'

Rspec.configure do |config|
 
end

require 'mongoa'
require File.expand_path(File.dirname(__FILE__) + '/../lib/mongoa/mongo_mapper/association_matcher')

