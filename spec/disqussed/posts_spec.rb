require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Posts do
  describe "create" do
    describe "failure" do
      context "no message" do
        use_vcr_cassette

        before :each do
          @resp = Disqussed::Posts.create
        end

        it "returns with a 400 HTTP status code" do
          @resp.code.should == 400
        end

        it "returns with a response code 2" do
          @resp['code'].should == 2
        end
      end

      context "no thread" do
        use_vcr_cassette

        before :each do
          @resp = Disqussed::Posts.create("missing thread")
        end

        it "returns with a 400 HTTP status code" do
          @resp.code.should == 400
        end

        it "returns with a response code 2" do
          @resp['code'].should == 2
        end
      end

      context "no privileges" do
        use_vcr_cassette

        before :each do
          @resp = Disqussed::Posts.create("no privileges", { :thread => "808" })
        end

        it "returns with a 400 HTTP status code" do
          @resp.code.should == 400
        end

        it "returns with a response code 12" do
          @resp['code'].should == 12
        end
      end
    end

    context "success" do
      use_vcr_cassette

      before :each do
        @thread = Disqussed::Threads.create("stipple", Time.now.to_f)
        @resp = Disqussed::Posts.create("test", { :thread => @thread['response']['id'] })
      end

      it "returns with a 200 HTTP Status code" do
        @resp.code.should == 200
      end
    end
  end

  describe "list" do
    describe "success" do
      context "all thread posts" do
        use_vcr_cassette

        before :each do
          @resp = Disqussed::Posts.list
        end

        it "returns a list of posts" do
          @resp['response'].should_not be_empty
        end

        it "returns with a 200 HTTP status code" do
          @resp.code.should == 200
        end
      end

      context "specific thread posts" do
        use_vcr_cassette

        before :each do
          @thread = Disqussed::Threads.create("stipple", Time.now.to_f)
          Disqussed::Posts.create("test", { :thread => @thread['response']['id'] })
          Disqussed::Posts.create("test 2", { :thread => @thread['response']['id'] })
          @resp = Disqussed::Posts.list({:forum => "stipple", :thread => @thread['response']['id']})
        end

        it "returns a list of posts" do
          @resp['response'].should_not be_empty
        end

        it "returns with a 200 HTTP status code" do
          @resp.code.should == 200
        end
      end
    end
  end
end