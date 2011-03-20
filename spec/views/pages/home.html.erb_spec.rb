require 'spec_helper'

describe "pages/home.html.erb" do
  it "should have the right title" do
    render

    assert_select "title", :content => "Tutorial | Home"
  end
end
