require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "#validates_length_of or key :length => <length_options>" do
    
    [Post, PostActiveModel].each do |model_class|
      context "#{model_class}" do
        describe "validates_length_of" do
          describe "maximum" do
            it "should return true if the key has a validates_length of with the specified :maximum" do
              validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :maximum => 32)
              validation.should be_matches(model_class.new)
            end    
    
            it "should return false if the key has a validates_length but the maximum's don't match" do
              validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :maximum => 25)
              validation.should_not be_matches(model_class.new)
            end    
    
            it "should return false if the key does not have a validates_length of" do
              validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:foo, :maximum => 32)
              validation.should_not be_matches(model_class.new)
            end
          end
    
          describe "minimum" do
            it "should return true if the key has a validates_length of with the specified :minimum" do
              validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :minimum => 4)
              validation.should be_matches(model_class.new)
            end    
    
            it "should return false if the key has a validates_length of but the minimum's don't match" do
              validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :minimum => 2)
              validation.should_not be_matches(model_class.new)
            end    
    
            it "should return false if the key does not have a validates_length" do
              validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:foo, :minimum => 32)
              validation.should_not be_matches(model_class.new)
            end
          end
        end
      end
    end

    [PostRequiredActiveModel].each do |model_class|
      context "#{model_class}" do
        describe "length" do
          it "should work the same as validates_length_of" do
            validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :length => 32)
            validation.should be_matches(model_class.new)
            
            validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :length => 25)
            validation.should_not be_matches(model_class.new)
            
            validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:foo, :length => 32)
            validation.should_not be_matches(model_class.new)

            validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:range_name, :length => 0..56)
            validation.should be_matches(model_class.new)
          end
        end
      end
    end
  end
end