module Mongoa
  module MongoMapper
    module Matchers
      class ValidateLengthOfMatcher < ValidateBase
        def initialize(attribute, length_options)
          super(attribute)

          if length_options[:length]  
            @length_options = case length_options[:length]
            when Integer
              { :minimum => 0, :maximum => length_options[:length] }
            when Range
              { :within => length_options[:length] }
            when Hash
              length_options[:length]
            end
          else
            @length_options = length_options
          end
        end

        def matches?(subject)
          super(subject)
          if @validation
            if @length_options.keys.include?(:minimum)
              result = minimum == @length_options[:minimum]
              return false if !result
            end
            
            if @length_options.keys.include?(:maximum)
              result = maximum == @length_options[:maximum]
              return false if !result
            end

            if @length_options.keys.include?(:within)
              result = within == @length_options[:within]
              return false if !result
            end
            true
          else
            return false
          end
        end

        def description
          "require #{@attribute} to be a maximum length of #{@maximum}"
        end

        def failure_message
          "Expected #{@attribute}  to be a maximum length of #{@maximum}"
        end

        def negative_failure_message
          "Expected #{@attribute} to not be a maximum length of #{@maximum}"
        end
        
        private 
        
        def validation_type
          "ValidatesLengthOf"
        end
        
        def validator_class_name
           "ActiveModel::Validations::LengthValidator"
        end
        
        def minimum
          @validation.respond_to?(:minimum) ? @validation.minimum : @validation.options[:minimum]
        end
        
        def maximum
          @validation.respond_to?(:maximum) ? @validation.maximum : @validation.options[:maximum]
        end

        def within
          if @validation.respond_to?(:within) 
            @validation.within
          else
            (@validation.options[:minimum]..@validation.options[:maximum])
          end
        end
      end
    end
  end
end