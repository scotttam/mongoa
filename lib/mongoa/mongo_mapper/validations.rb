module Mongoa
  module MongoMapper
    module Matchers
      def validate_presence_of(attr)
        ValidateMatcher.new("ValidatesPresenceOf", attr)
      end
    end

    class ValidateMatcher
      attr_reader :validation_type
      attr_reader :attribute
      
      def initialize(validation_type, attribute)
        @validation_type = validation_type
        @attribute = attribute
      end

      def matches?(subject)
        @subject = subject
        attr_validations = model_class.validations.select { |validation| validation.attribute == attribute }
        return false unless attr_validations
        attr_validations.detect { |validation| validation.key.include?(validation_type) }
      end

      def description
        "require #{@attribute} to be set"
      end

      def failure_message
        "#{@attribute} to be a required field (validates_presence_of) but was not"
      end

      def negative_failure_message
        "#{@attribute} to not be a required field (validates_presence_of), but it was"
      end
      
      private

      def model_class
        @subject.class
      end
    end
  end
end