require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Tutorial |"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should render the correct title" do
      get 'home'
      assert_select "title", :content => "#{@base_title} Home"
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should render the correct title" do
      get 'about'
      assert_select "title", :content => "#{@base_title} | About"
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should render the correct title" do
      get 'help'
      assert_select "title", :content => "#{@base_title} | Help"
    end
  end
end
