require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "validates_uniqueness_of or key required => :true" do
    describe "#validates_uniqueness_of" do
      it "should return true if the key has a validates_presence_of validtion" do
        validation = Mongoa::MongoMapper::Matchers::ValidateUniquenessOfMatcher.new(:unique_name)
        validation.should be_matches(Post.new)
      end
    
      it "should return false if the key does not have a validates_presence_of validtion" do
        validation = Mongoa::MongoMapper::Matchers::ValidateUniquenessOfMatcher.new(:foo)
        validation.should_not be_matches(Post.new)
      end
    end
      
    describe "unique" do
      it "should work the same if the key is unique rather than validates_presence_of" do
        validation = Mongoa::MongoMapper::Matchers::ValidateUniquenessOfMatcher.new(:unique_name)
        validation.should be_matches(PostRequired.new)
    
        validation = Mongoa::MongoMapper::Matchers::ValidateUniquenessOfMatcher.new(:foo)
        validation.should_not be_matches(PostRequired.new)
      end
    end
  end
end