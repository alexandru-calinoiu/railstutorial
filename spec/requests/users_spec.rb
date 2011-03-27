require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          click_button
          response.should render_template("users/new")
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "calin"
          fill_in "Email",        :with => "calin@email.com"
          fill_in "Password",     :with => "password"
          fill_in "Confirmation", :with => "password"
          click_button
          response.should render_template("users/show")
        end.should change(User, :count).by(1)
      end
    end
  end
end
