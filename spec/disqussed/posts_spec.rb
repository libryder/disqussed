require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Posts do
  describe "create" do
    context "no message" do
      use_vcr_cassette

      it "should raise an error" do
        lambda {
          Disqussed::Posts.create
        }.should raise_error
      end
    end

    context "message" do
      use_vcr_cassette

      it "should not raise an error" do
        lambda {
          Disqussed::Posts.create("test")
        }.should_not raise_error
      end

      it "should create the post" do
        p Disqussed::Posts.create("test")

      end
    end
  end

  describe "list" do
    context "success" do
      use_vcr_cassette

      before :each do
        @resp = Disqussed::Posts.list
      end

      it "returns a list of posts" do
        @resp['response'].should_not be_empty
      end

      it "returns with a 200 success code" do
        @resp.code.should == 200
      end
    end
  end
end