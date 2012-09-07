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

  describe "details" do
    context "success" do
      use_vcr_cassette

      before :each do
        @thread = Disqussed::Threads.create("stipple", Time.now.to_f)
        Disqussed::Posts.create("test", { :thread => @thread['response']['id'] })
        Disqussed::Posts.create("test1", { :thread => @thread['response']['id'] })
        Disqussed::Posts.create("test2", { :thread => @thread['response']['id'] })

        @details = Disqussed::Threads.details(@thread['response']['id'])
      end

      it "returns with a 200 HTTP Status code" do
        @details.code.should == 200
      end

      it "returns a count of the posts" do
        @details["response"]["posts"].should == 3
      end
    end
  end

  describe "post_count" do
    context "success" do
      use_vcr_cassette

      before :each do
        @thread = Disqussed::Threads.create("stipple", Time.now.to_f)
        Disqussed::Posts.create("test", { :thread => @thread['response']['id'] })
        Disqussed::Posts.create("test1", { :thread => @thread['response']['id'] })
        Disqussed::Posts.create("test2", { :thread => @thread['response']['id'] })
        Disqussed::Posts.create("test3", { :thread => @thread['response']['id'] })

        @count = Disqussed::Threads.post_count(@thread['response']['id'])
      end

      it "returns a count of the posts" do
        @count.should == 4
      end
    end
  end

  describe "remove" do
    context "success" do
      use_vcr_cassette

      before :each do
        @create = Disqussed::Threads.create("stipple", Time.now.to_f)
        @delete = Disqussed::Threads.remove(@create['response']['id'])
      end

      it "returns with a 200 HTTP Status code" do
        @delete.code.should == 200
      end
    end
  end

end