module Mongoa
  module MongoMapper
    module Matchers
      class ValidatePresenceOfMatcher < ValidateBase
        def description
          "require #{@attribute} to be set"
        end

        def failure_message
          "Expected #{@attribute} to be a required field (validates_presence_of or :required => true) but was not"
        end

        def negative_failure_message
          "Expected #{@attribute} to not be a required field (validates_presence_of or :required => true), but it was"
        end
        
        private
        
        def validation_type
          "ValidatesPresenceOf"
        end
        
        def validator_class_name
          "ActiveModel::Validations::PresenceValidator"
        end
      end
    end
  end
end