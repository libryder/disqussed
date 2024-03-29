require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Threads do
  before :each do
    Disqussed::defaults[:sso] = true

    @user = { :username => "Tester", :id => "1", :email => "test_account1@stipple.com" }
    @user2 = { :username => "Tester 2", :id => "2", :email => "test_account2@stipple.com" }
  end

  describe "create" do
    context "success" do
      use_vcr_cassette

      before :each do
        @resp = Disqussed::Threads.create(Disqussed::defaults[:forum], Time.now.to_f)
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
        @thread = Disqussed::Threads.create(Disqussed::defaults[:forum], Time.now.to_f)
        Disqussed::Posts.create("test1", { :thread => @thread['response']['id'] }, @user2)

        @details = Disqussed::Threads.details(@thread['response']['id'])
      end

      it "returns with a 200 HTTP Status code" do
        @details.code.should == 200
      end

      it "returns a count of the posts" do
        @details["response"]["posts"].should == 1
      end
    end
  end

  #describe "get_thread_id_by_ident" do
  #  context "success"do
  #    use_vcr_cassette
  #
  #    before :each do
  #      @ident = SecureRandom.hex(10)
  #
  #      @thread = Disqussed::Threads.create(Disqussed::defaults[:forum], Time.now.to_f, {:identifier => @ident })
  #
  #      @id = Disqussed::Threads.get_thread_id_by_ident(@ident)
  #    end
  #
  #    after :each do
  #      @thread = Disqussed::Threads.remove_thread_by_ident(@ident)
  #    end
  #
  #    it "returns with a 200 HTTP Status code" do
  #      @id.code.should == 200
  #    end
  #
  #    it "returns the id" do
  #      @id["response"]["id"].should == @thread["response"]["id"]
  #    end
  #  end
  #end

  describe "post_count" do
    context "success" do
      use_vcr_cassette

      before :each do
        @thread = Disqussed::Threads.create(Disqussed::defaults[:forum], Time.now.to_f)
        Disqussed::Posts.create("test", { :thread => @thread['response']['id'] }, @user)
      end

      it "returns a count of the posts" do
        @count = Disqussed::Threads.post_count(@thread['response']['id'])

        @count.should == 1
      end
    end
  end

  describe "remove" do
    context "success" do
      use_vcr_cassette

      before :each do
        @create = Disqussed::Threads.create(Disqussed::defaults[:forum], Time.now.to_f)
        @delete = Disqussed::Threads.remove(@create['response']['id'])
      end

      it "returns with a 200 HTTP Status code" do
        @delete.code.should == 200
      end
    end
  end

  #describe "remove_thread_by_ident" do
  #  context "success"do
  #    use_vcr_cassette
  #
  #    before :each do
  #      ident = "Test-Photo"
  #      @thread = Disqussed::Threads.create(Disqussed::defaults[:forum], Time.now.to_f, {:identifier => ident })
  #      @thread = Disqussed::Threads.remove_thread_by_ident(ident)
  #    end
  #
  #    it "returns with a 200 HTTP Status code" do
  #      @thread.code.should == 200
  #    end
  #  end
  #end
end