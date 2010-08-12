module Mongoa
  module MongoMapper
    module Matchers
      class ValidateBase
        attr_reader :attribute
  
        def initialize(attribute)
          @attribute = attribute
        end

        def matches?(subject)
          @subject = subject
          @validation = find_validation
        end

        def validation_type
          raise "Redefine in the subclass"
        end
        
        private

        def model_class
          @subject.class
        end
        
        def find_validation
          attr_validations = model_class.validations.select { |validation| validation.attribute == attribute }
          return nil unless attr_validations
          validation = attr_validations.detect { |validation| validation.key.include?(validation_type) }
        end        
      end
    end
  end
end