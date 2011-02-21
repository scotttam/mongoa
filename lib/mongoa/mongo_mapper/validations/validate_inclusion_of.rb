module Mongoa
  module MongoMapper
    module Matchers
      class ValidateInclusionOfMatcher < ValidateBase
        def initialize(attribute, within)
          super(attribute)
          @within = within
        end

        def matches?(subject)
          super(subject)
          @validation ? within == @within : false
        end

        def description
          "require #{@attribute} to be within #{@within}"
        end

        def failure_message
          "Expected #{@attribute} to be within #{@within} but was not"
        end

        def negative_failure_message
          "Expected #{@attribute} to not be within #{@within} but was"
        end
        
        private 
        
        def validation_type
          "ValidatesInclusionOf"
        end
        
        def validator_class_name
           "ActiveModel::Validations::InclusionValidator"
        end
        
        #MM - master branch has removed the within
        def within
          @validation.respond_to?(:within) ? @validation.within : @validation.options[:in]
        end
      end
    end
  end
end