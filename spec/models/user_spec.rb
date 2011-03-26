require 'spec_helper'

describe User do
  describe "initialize" do
    it "should set the attributes" do
      user = User.new(:name => "ion", :email => "ion@gmail.com")

      user.name.should == "ion"
      user.email.should == "ion@gmail.com"
    end
  end

  describe "formatted email" do
    it "should be correct for a user and a email" do
      user = User.new(:name => "ion", :email => "ion@gmail.com")

      user.formatted_email.should == "ion | <ion@gmail.com>"
    end
  end
end
