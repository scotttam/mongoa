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
              result = @validation.minimum == @length_options[:minimum]
              return false if !result
            end
            
            if @length_options.keys.include?(:maximum)
              result = @validation.maximum == @length_options[:maximum]
              return false if !result
            end

            if @length_options.keys.include?(:within)            
              result = @validation.within == @length_options[:within]
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
      end
    end
  end
end