require 'spec_helper'

describe User do
  before :each do
    @attr = {
        :name => "Example User",
        :email => "example@email.com",
        :password => "foobar",
        :password_confirmation => "foobar"
    }
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

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should reject short passwords" do
      short_password = "a" * 5
      User.new(@attr.merge(:password => short_password, :password_confirmation => short_password)).should_not be_valid
    end

    it "should reject long passwords" do
      long_password = "a" * 41
      User.new(@attr.merge(:password => long_password, :password_confirmation => long_password)).should_not be_valid
    end
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

  describe "password encryption" do
    before :each do
      @user = User.create!(@attr)
    end

    it "should have the encrypted password field" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password?" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should not be true if the password don't match" do
        @user.has_password?("invalid").should be_false
      end

      describe "authenticate method" do
        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongness")
          wrong_password_user.should be_nil
        end

        it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
        end

        it "should return the user on email/password match" do
          matching_user = User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @user
        end
      end
    end
  end

  describe "authenticate_with_salt" do
    before :each do
      @user = Factory(:user)
    end

    it "should return user for valid salt" do
      User.authenticate_with_salt(@user.id, @user.salt).should_not be_nil
    end

    it "should return nil for invalid salt" do
      User.authenticate_with_salt(@user.id, nil).should be_nil
    end
  end

  describe "admin attribute" do
    before :each do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
end
