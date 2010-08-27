require 'mongoa/mongo_mapper/associations/all'
require 'mongoa/mongo_mapper/validations/validate_base'
require 'mongoa/mongo_mapper/validations/validate_presence_of'
require 'mongoa/mongo_mapper/validations/validate_inclusion_of'
require 'mongoa/mongo_mapper/validations/validate_uniqueness_of'
require 'mongoa/mongo_mapper/validations/validate_length_of'

module Mongoa
  module MongoMapper
    module Matchers
      def belong_to(name)
        MongoAssociationMatcher.new(:belongs_to, name)
      end

      def have_many(name)
        MongoAssociationMatcher.new(:has_many, name)
      end

      def have_one(name)
        MongoAssociationMatcher.new(:has_one, name)
      end
      
      def validate_presence_of(attr)
        ValidatePresenceOfMatcher.new(attr)
      end
      
      def validate_inclusion_of(attr, within)
        ValidateInclusionOfMatcher.new(attr, within)
      end

      def validate_uniqueness_of(attr)
        ValidateUniquenessOfMatcher.new(attr)
      end

      def validate_length_of(attr, length_options)
        ValidateLengthOfMatcher.new(attr, length_options)
      end
    end
  end
end