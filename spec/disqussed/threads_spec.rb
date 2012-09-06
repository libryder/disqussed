require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Threads do
  describe "create" do
    context "success" do
      use_vcr_cassette

      before :each do
        @resp = Disqussed::Threads.create("stipple", Time.now.to_f)
      end

      after :each do
        Disqussed::Threads.remove(@resp['response']['id'])
      end

      it "returns with a 200 HTTP Status code" do
        @resp.code.should == 200
      end
    end
  end

  describe "remove" do
    context "success" do
      use_vcr_cassette

      before :each do
        @create = Disqussed::Threads.create("stipple", "create test")
        @delete = Disqussed::Threads.remove(@create['response']['id'])
      end

      it "returns with a 200 HTTP Status code" do
        @delete.code.should == 200
      end
    end
  end

end