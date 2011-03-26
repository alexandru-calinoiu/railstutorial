require 'spec_helper'

describe User do
  before :each do
    @attr = { :name => "Example User", :email => "example@email.com" }
  end

  it "should create a new instance give valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are to longer than 50 chars" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate emails" do
    User.create!(@attr)
    duplicated_user = User.new(@attr)
    duplicated_user.should_not be_valid
  end

  it "should reject duplicate emails even for upcase" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    duplicated_user = User.new(@attr)
    duplicated_user.should_not be_valid
  end

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
