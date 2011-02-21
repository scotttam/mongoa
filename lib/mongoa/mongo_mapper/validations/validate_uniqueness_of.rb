module Mongoa
  module MongoMapper
    module Matchers
      class ValidateUniquenessOfMatcher < ValidateBase
        def initialize(attribute)
          super(attribute)
        end

        def matches?(subject)
          super(subject)
        end

        def description
          "require #{@attribute} to be unique"
        end

        def failure_message
          "Expected #{@attribute} to be unique but was not"
        end

        def negative_failure_message
          "Expected #{@attribute} not to be unique but was"
        end
        
        private 
        
        def validation_type
          "ValidatesUniquenessOf"
        end
        
        def validator_class_name
          "MongoMapper::Plugins::Validations::UniquenessValidator"
        end
      end
    end
  end
end