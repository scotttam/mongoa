require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "validates_exclusion_of or key not_in => :true" do
    describe "#validates_exclusion_of" do
      context "in" do
        it "should return true if the key has a validates_exclusion_of validtion and it's value is not in the list" do
          # validation = Mongoa::MongoMapper::Matchers::ValidateExclusionOfMatcher.new(:name)
          # validation.in(%w(admin user)).should be_matches(Post.new)
        end

        it "should raise an exception if the in is not specified" do
        # it "should return false if the key does not have a validates_presence_of validtion" do
        #   validation = Mongoa::MongoMapper::Matchers::ValidateExclusionOfMatcher.new(:foo)
        #   validation.should_not be_matches(Post.new)
        # end
        end
      end
    end
  
    describe "not_in" do
      # it "should work the same if the key is required rather than validates_presence_of" do
      #   validation = Mongoa::MongoMapper::Matchers::ValidateExclusionOfMatcher.new(:name)
      #   validation.should be_matches(PostRequired.new)
      # 
      #   validation = Mongoa::MongoMapper::Matchers::ValidateExclusionOfMatcher.new(:foo)
      #   validation.should_not be_matches(PostRequired.new)
      # end
    end
  end
end