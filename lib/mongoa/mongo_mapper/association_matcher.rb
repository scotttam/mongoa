module Mongoa
  module MongoMapper
    module Matchers
      def belongs_to(name)
        MongoAssociationMatcher.new(:belongs_to, name)
      end

      def have_many(name)
        MongoAssociationMatcher.new(:has_many, name)
      end
    end

    class MongoAssociationMatcher
      attr_reader :macro
      attr_reader :name

      #macro = belongs_to, has_many, etc
      #name  = template (right side of the relationship)
      def initialize(macro, name)
        @macro = macro
        @name  = name
      end

      def matches?(subject)
        if subject.is_a?(String)
          @expection = "You're subject is a string... it should be a Model constant. See your parent describe block."
          return false
        end
        @subject = subject
        result = (association_exists? && macro_correct?)
        if result && macro == :belongs_to
          result = foreign_key_exists?
        end
        result
      end

      def failure_message
        "Expected #{expectation} (#{@missing})"
      end

      def negative_failure_message
        "Did not expect #{expectation}"
      end

      def negative_failure_message
        "Did not expect #{expectation}"
      end

      def description
        "#{macro_description} #{name}"
      end

      protected

      def association
        @association ||= model_class.find_association(name)
      end

      def model_class
        @subject.class
      end

      def expectation
        @expectation ||= "#{model_class.name} to have a #{macro} association called #{name}"
      end

      def macro_description
        case macro.to_s
        when 'belongs_to' then 'belong to'
        when 'has_many'   then 'have many'
        when 'has_one'    then 'have one'
        when 'has_and_belongs_to_many' then
          'have and belong to many'
        end
      end

      def association_exists?
        if !association
          @missing = "no association called #{name}"
          return false
        end
        true
      end
      
     def macro_correct?
        (association.type == :belongs_to && macro == :belongs_to) ||
        (association.type == :many && macro == :has_many)
      end

      def foreign_key_exists?
        !association.embeddable? && belongs_to_foreign_key_exists?
      end

      def belongs_to_foreign_key_exists?
        model_class.keys.keys.include?("#{reflection_name}_id")
      end

      def reflection_name
        @reflection ||= association.class_name.underscore
      end
    end
  end
end
