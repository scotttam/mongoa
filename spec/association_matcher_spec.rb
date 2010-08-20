require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Post
  include MongoMapper::Document
  key :name, String
  
  has_many :comments
  has_many :commentwoutfks
  has_many :embedded_comment_no_specifications
end

class PostWOutHM
  include MongoMapper::Document
  key :name, String
end

class Comment
  include MongoMapper::Document
  key :description, String
  key :post_id, ObjectId
  
  belongs_to :post
end

class EmbeddedComment
  include MongoMapper::EmbeddedDocument
  key :description, String
  
  belongs_to :post
end

class CommentWOutFK
  include MongoMapper::Document
  key :description, String
  
  belongs_to :post
end

class EmbeddedCommentNoSpecification
  include MongoMapper::EmbeddedDocument
end

class Employee
  include MongoMapper::Document
  key :name, :required => true
  
  has_one :office
end

class EmployeeWOutHO
  include MongoMapper::Document
  key :name, :required => true
  
end

class Office
  include MongoMapper::Document
  key :name, :required => true
  
  belongs_to :employee
end

describe Mongoa::MongoMapper::Matchers do
  describe "#belongs_to" do
    describe "document" do
      it "should return true of the belongs_to relationship is specified and the foreign key is present" do
        matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:belongs_to, :post)
        matcher.should be_matches(Comment.new)
      end
      
      it "should return false if the belongs_to is present but the foreign key is missing" do
        matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:belongs_to, :post)
        matcher.should_not be_matches(CommentWOutFK.new)
      end
    end
    
    describe "embedded" do
      it "should return true if the belongs_to relationship is specified" do
        matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:belongs_to, :post)
        matcher.should be_matches(EmbeddedComment.new)
      end
      
      it "should return false if the belongs_to relationship is not specified" do
        matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:belongs_to, :post)
        matcher.should_not be_matches(EmbeddedCommentNoSpecification.new)
      end
    end
  end
  
  describe "#has_many" do
    it "should return true if the has_many relationship is specified" do
      matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:has_many, :comments)
      matcher.should be_matches(Post.new)
    end
    
    it "should return false of the has_many relationship is not specified" do
      matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:has_many, :comments)
      matcher.should_not be_matches(PostWOutHM.new)
    end
  end
  
  describe "#has_one" do
    it "should return true if the has_one relationship is specified" do
      matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:has_one, :office)
      matcher.should be_matches(Employee.new)
    end
    
    it "should return false if the has_one relationship is not specified" do
      matcher = Mongoa::MongoMapper::MongoAssociationMatcher.new(:has_one, :office)
      matcher.should_not be_matches(EmployeeWOutHO.new)
    end
  end
end