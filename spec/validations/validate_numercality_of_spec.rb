require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "validates_numericality_of or key numeric" do
    [User, UserActiveModel].each do |model_class|
      context model_class do
        describe "#validates_numericality_of" do
          it "should return true if the key has a validates_numericality_of validtion" do
            validation = Mongoa::MongoMapper::Matchers::ValidateNumericalityOfMatcher.new(:years_alive)
            validation.should be_matches(model_class.new)
          end
      
          it "should return false if it doesn't have a validates_numericality_of" do
            validation = Mongoa::MongoMapper::Matchers::ValidateNumericalityOfMatcher.new(:foo)
            validation.should_not be_matches(model_class.new)
          end
        end
      
        describe "numeric" do
          it "should work the same if the key is numeric rather than validates_numericality_of" do
            validation = Mongoa::MongoMapper::Matchers::ValidateNumericalityOfMatcher.new(:years_alive_numeric)
            validation.should be_matches(model_class.new)
          end
        end
      end
    end
  end
end