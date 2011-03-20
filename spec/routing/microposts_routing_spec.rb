require "spec_helper"

describe MicropostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/microposts" }.should route_to(:controller => "microposts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/microposts/new" }.should route_to(:controller => "microposts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/microposts/1" }.should route_to(:controller => "microposts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/microposts/1/edit" }.should route_to(:controller => "microposts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/microposts" }.should route_to(:controller => "microposts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/microposts/1" }.should route_to(:controller => "microposts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/microposts/1" }.should route_to(:controller => "microposts", :action => "destroy", :id => "1")
    end

  end
end
