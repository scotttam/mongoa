require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Post
  include MongoMapper::Document
  
  key :name, String
  
  validates_presence_of :name
  validates_length_of :name, :minimum => 4, :maximum => 32
end

class PostRequired
  include MongoMapper::Document
  
  key :name, String, :required => true, :length => 32
  key :range_name, String, :required => true, :length => 0..56
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
  
  describe "#validates_length_of or key :length => <length_options>" do
    describe "validates_length_of" do
      describe "maximum" do
        it "should return true if the key has a validates_length of with the specified :maximum" do
          validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :maximum => 32)
          validation.should be_matches(Post.new)
        end    

        it "should return false if the key has a validates_length but the maximum's don't match" do
          validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :maximum => 25)
          validation.should_not be_matches(Post.new)
        end    

        it "should return false if the key does not have a validates_length of" do
          validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:foo, :maximum => 32)
          validation.should_not be_matches(Post.new)
        end
      end
      
      describe "minimum" do
        it "should return true if the key has a validates_length of with the specified :minimum" do
          validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :minimum => 4)
          validation.should be_matches(Post.new)
        end    

        it "should return false if the key has a validates_length of but the minimum's don't match" do
          validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :minimum => 2)
          validation.should_not be_matches(Post.new)
        end    

        it "should return false if the key does not have a validates_length" do
          validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:foo, :minimum => 32)
          validation.should_not be_matches(Post.new)
        end
      end
    end
    
    describe "length" do
      it "should work the same as validates_length_of" do
        validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :length => 32)
        validation.should be_matches(PostRequired.new)

        validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:name, :length => 25)
        validation.should_not be_matches(PostRequired.new)

        validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:foo, :length => 32)
        validation.should_not be_matches(PostRequired.new)

        validation = Mongoa::MongoMapper::Matchers::ValidateLengthOfMatcher.new(:range_name, :length => 0..56)
        validation.should be_matches(PostRequired.new)
      end
    end    
  end
end
