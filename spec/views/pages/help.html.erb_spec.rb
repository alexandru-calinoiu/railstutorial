require "spec_helper"

describe "pages/help.html.erb" do
  it "should have the right title" do
    render

    assert_select "title", :content => "Tutorial | Help"
  end
end