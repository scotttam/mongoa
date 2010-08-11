require 'mongoa/mongo_mapper/matchers'

module RSpec
  module Matchers
    include Mongoa::MongoMapper::Matchers
    # include Mongoa::MongoMapper::ValidateMatcher
  end
end

