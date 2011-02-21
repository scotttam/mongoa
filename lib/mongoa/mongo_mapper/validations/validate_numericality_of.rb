module Mongoa
  module MongoMapper
    module Matchers
      class ValidateNumericalityOfMatcher < ValidateBase
        def initialize(attribute)
          super(attribute)
        end

        def matches?(subject)
          super(subject)
        end

        def description
          "require #{@attribute} to validate the numericality of"
        end

        def failure_message
          "Expected #{@attribute} to validate the numericality of but didn't"
        end

        def negative_failure_message
          "Expected #{@attribute} not to validate the numericality but did"
        end
        
        private 
        
        def validation_type
          "ValidatesNumericalityOf"
        end
        
        def validator_class_name
           "ActiveModel::Validations::NumericalityValidator"
        end
      end
    end
  end
end