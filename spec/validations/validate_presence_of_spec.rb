require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "validates_presence_of or key required => :true" do

    [Post, PostActiveModel].each do |model_class|
      context "#{model_class}" do
        describe "#validates_presence_of" do
          it "should return true if the key has a validates_presence_of validtion" do
            validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:name)
            validation.should be_matches(model_class.new)
          end

          it "should return false if the key does not have a validates_presence_of validtion" do
            validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:foo)
            validation.should_not be_matches(model_class.new)
          end
        end
      end
    end
  
    [PostRequired, PostRequiredActiveModel].each do |model_class|
      context "#{model_class}" do
        describe "required" do
          it "should work the same if the key is required rather than validates_presence_of" do
            validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:name)
            validation.should be_matches(model_class.new)

            validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:foo)
            validation.should_not be_matches(model_class.new)
          end
        end
      end
    end
  end
end