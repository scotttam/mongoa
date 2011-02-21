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

        def validator_class_name
          raise "Redefine in the subclass"
        end
        
        private

        def model_class
          @subject.class
        end
        
        def find_validation
          if model_class.respond_to?(:validators)
            model_class.validators.detect do |validator|
              validator.class.to_s == validator_class_name && validator.attributes.include?(attribute)
            end
          else
            attr_validations = model_class.validations.select { |validation| validation.attribute == attribute }
            return nil unless attr_validations
            attr_validations.detect { |validation| validation.key.include?(validation_type) }
          end
        end
      end
    end
  end
end