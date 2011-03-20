require 'spec_helper'

describe Micropost do
  describe "content" do
    it "should be invalid if longer than 140 chars" do
      micropost = Micropost.new(:content => (0...141).map { ('a'..'z').to_a[rand(26)] }.join)

      micropost.should have(1).error_on(:content)
    end
  end
end
