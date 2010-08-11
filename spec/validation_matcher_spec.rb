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


describe Mongoa::MongoMapper::Matchers do
  describe "#validates_presence_of" do
    it "should return true if the key has a validates_presence_of validtion" do
      validation = Mongoa::MongoMapper::ValidateMatcher.new("ValidatesPresenceOf", :name)
      validation.should be_matches(Post.new)
    end

    it "should return false if the key does not have a validates_presence_of validtion" do
      validation = Mongoa::MongoMapper::ValidateMatcher.new("ValidatesPresenceOf", :foo)
      validation.should_not be_matches(Post.new)
    end
  end
  
  describe "required" do
    it "should work the same if the key is required rather than validates_presence_of" do
      validation = Mongoa::MongoMapper::ValidateMatcher.new("ValidatesPresenceOf", :name)
      validation.should be_matches(PostRequired.new)

      validation = Mongoa::MongoMapper::ValidateMatcher.new("ValidatesPresenceOf", :foo)
      validation.should_not be_matches(PostRequired.new)
    end
  end
end
