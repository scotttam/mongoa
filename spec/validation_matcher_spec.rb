require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Post
  include MongoMapper::Document
  
  key :name, String
  
  validates_presence_of :name
end

class PostRequired
  include MongoMapper::Document
  
  key :name, String, :required => true
end

class Within
  include MongoMapper::Document
  
  key :state, String
  
  validates_inclusion_of :state, :within => ["new", "uploaded"]
end

class WithinIn
  include MongoMapper::Document
  
  key :state, String, :in => ["new", "uploaded"]
end

describe Mongoa::MongoMapper::Matchers do
  describe "validates_presence_of or key required => :true" do
    describe "#validates_presence_of" do
      it "should return true if the key has a validates_presence_of validtion" do
        validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:name)
        validation.should be_matches(Post.new)
      end

      it "should return false if the key does not have a validates_presence_of validtion" do
        validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:foo)
        validation.should_not be_matches(Post.new)
      end
    end
  
    describe "required" do
      it "should work the same if the key is required rather than validates_presence_of" do
        validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:name)
        validation.should be_matches(PostRequired.new)

        validation = Mongoa::MongoMapper::Matchers::ValidatePresenceOfMatcher.new(:foo)
        validation.should_not be_matches(PostRequired.new)
      end
    end
  end
  
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
