module Mongoa
  module MongoMapper
    module Matchers
      
      def validate_presence_of(attr)
        ValidatePresenceOfMatcher.new(attr)
      end

      class ValidatePresenceOfMatcher < ValidationMatcher

        def with_message(message)
          @expected_message = message if message
          self
        end

        def matches?(subject)
          super(subject)
          @expected_message ||= :blank
          disallows_value_of(blank_value, @expected_message)
        end

        def description
          "require #{@attribute} to be set"
        end

        private

        def blank_value
          if collection?
            []
          else
            nil
          end
        end

        def collection?
          if reflection = @subject.class.reflect_on_association(@attribute)
            [:has_many, :has_and_belongs_to_many].include?(reflection.macro)
          else
            false
          end
        end
      end
      
    end
  end
end