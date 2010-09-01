require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoa::MongoMapper do
  describe "validates_format_of or key format => <whatev>" do
    describe "#validates_format_of" do
      context "with" do
        before(:each) do
          @validation = Mongoa::MongoMapper::Matchers::ValidateFormatOfMatcher.new(:email)
        end
        it "should return true if the key has a validates_presence_of validtion" do
          @validation.with(/(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i).should be_matches(User.new)
        end
        
        it "should return false if the with doesn't match" do
          @validation.with(/blah/i).should_not be_matches(User.new)
        end
        
        it "should raise an exception if the required option :with is not specified" do
          lambda { @validation.matches?(User.new) }.should raise_error(RuntimeError)
        end
      end
      
      it "should return false if the key does not have a validates_format_of validtion" do
        validation = Mongoa::MongoMapper::Matchers::ValidateFormatOfMatcher.new(:name)
        validation.with(/(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i).should_not be_matches(User.new)
      end
    end
      
    describe "format" do
      it "should work the same if the key is format rather than validates_format_of" do
        validation = Mongoa::MongoMapper::Matchers::ValidateFormatOfMatcher.new(:email_format)
        validation.with(/(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i).should be_matches(User.new)
      end
    end
  end
end