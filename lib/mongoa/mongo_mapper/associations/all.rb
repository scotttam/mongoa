module Mongoa
  module MongoMapper
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
        result = foreign_key_exists? if result && macro == :belongs_to && !subject.class.embeddable?
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
        @association ||= find_association(model_class, name)
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
        #The master branch version of mongo_mapper changed the associations to have concrete classes rather than be 
        #MongoMapper::Plugins::Associations::Base and removed the type method.
        if association.respond_to?(:type)
          (association.type == :belongs_to && macro == :belongs_to) ||
          (association.type == :many && macro == :has_many) ||
          (association.type == :one && macro == :has_one)
        else
          (association.class.to_s == "MongoMapper::Plugins::Associations::BelongsToAssociation" && macro == :belongs_to) ||
          (association.class.to_s == "MongoMapper::Plugins::Associations::ManyAssociation" && macro == :has_many) ||
          (association.class.to_s == "MongoMapper::Plugins::Associations::OneAssociation" && macro == :has_one)
        end
      end

      def foreign_key_exists?
        !association.embeddable? && belongs_to_foreign_key_exists?
      end

      def belongs_to_foreign_key_exists?
        foreign_key = model_class.keys["#{association.name}_id"]
        foreign_key && foreign_key.type
      end

      def reflection_name
        @reflection ||= association.class_name.underscore
        @reflection
      end
      
      def find_association(model_class, name)
        name_association = model_class.associations.detect {|key, value| key.to_s == name.to_s}
        name_association ? name_association.last : nil
      end
    end
  end
end