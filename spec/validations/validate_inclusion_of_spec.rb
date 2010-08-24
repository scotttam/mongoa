require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "#validates_inclusion_of or key :in => []" do
    describe "validates_inclusion_of" do
      it "should return true if the key has a validate_inclusion_of with the specified within" do
        validation = Mongoa::MongoMapper::Matchers::ValidateInclusionOfMatcher.new(:state, ["new", "uploaded"])
        validation.should be_matches(Within.new)
      end
  
      it "should return false if the key has a validate_inclusion_of but the within doesn't match" do
        validation = Mongoa::MongoMapper::Matchers::ValidateInclusionOfMatcher.new(:state, ["goo", "gaa"])
        validation.should_not be_matches(Within.new)
      end

      it "should return false if the key does not have a validate_inclusion_of set" do
        validation = Mongoa::MongoMapper::Matchers::ValidateInclusionOfMatcher.new(:foo, ["new", "uploaded"])
        validation.should_not be_matches(Within.new)
      end
    end

    describe "in" do    
      it "should work the same as validates_inclusion_of" do
        validation = Mongoa::MongoMapper::Matchers::ValidateInclusionOfMatcher.new(:state, ["new", "uploaded"])
        validation.should be_matches(WithinIn.new)

        validation = Mongoa::MongoMapper::Matchers::ValidateInclusionOfMatcher.new(:state, ["goo", "gaa"])
        validation.should_not be_matches(WithinIn.new)

        validation = Mongoa::MongoMapper::Matchers::ValidateInclusionOfMatcher.new(:foo, ["new", "uploaded"])
        validation.should_not be_matches(WithinIn.new)
      end
    end            
  end
end