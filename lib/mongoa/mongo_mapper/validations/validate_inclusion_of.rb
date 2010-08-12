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
          @validation ? @validation.within == @within : false
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
      end
    end
  end
end