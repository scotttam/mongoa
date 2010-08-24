require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mongoa::MongoMapper::Matchers do
  before(:all) do
    class TesterClass
      include Mongoa::MongoMapper::Matchers
    end
  end
  
  before(:each) do
    @tester = TesterClass.new
  end

  describe "associations" do
    it "should expose a belong_to, have_many and have_one methods" do
      @tester.methods.should include(:belong_to)
      @tester.methods.should include(:have_many)
      @tester.methods.should include(:have_one)
    end
  end
  
  describe "validations" do
    it "should expose validate_presence_of, validate_inclusion_of and validate_length_of methods" do
      @tester.methods.should include(:validate_presence_of)
      @tester.methods.should include(:validate_inclusion_of)
      @tester.methods.should include(:validate_length_of)
    end
  end
end