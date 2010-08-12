require 'mongoa/mongo_mapper/validations/validate_base'
require 'mongoa/mongo_mapper/validations/validate_presence_of'
require 'mongoa/mongo_mapper/validations/validate_inclusion_of'
require 'mongoa/mongo_mapper/validations/validate_length_of'

module Mongoa
  module MongoMapper
    module Matchers
      def validate_presence_of(attr)
        ValidatePresenceOfMatcher.new(attr)
      end
      
      def validate_inclusion_of(attr, within)
        ValidateInclusionOfMatcher.new(attr, within)
      end

      def validate_length_of(attr, length_options)
        ValidateLegnthOfMatcher.new(attr, length_options)
      end
    end
  end
end