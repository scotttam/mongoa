module Mongoa
  module MongoMapper
    module Matchers
      class ValidateFormatOfMatcher < ValidateBase
        def initialize(attribute)
          super(attribute)
        end

        def matches?(subject)
          super(subject)
          raise "The :with is a required option to be checked, but you didn't check it." if !@with
          @validation.with == @with if @validation && @validation.with
        end

        def with(value)
          raise "Can't use both with and not with" if @not_with
          @with = value
          self
        end

        def description
          "require #{@attribute} to validate the format of"
        end

        def failure_message
          "Expected #{@attribute} to validate the format of but didn't"
        end

        def negative_failure_message
          "Expected #{@attribute} not to validate the format but did"
        end
        
        private 
        
        def validation_type
          "ValidatesFormatOf"
        end
      end
    end
  end
end