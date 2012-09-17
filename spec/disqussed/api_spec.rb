require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Api do
  before :each do
    Disqussed::defaults[:sso] = false
  end

  describe "post" do
    it "builds a simple Disqus Post Request" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => Disqussed::defaults[:api_key],
                         :api_secret => Disqussed::defaults[:secret_key] })

      Disqussed::Api.request('post', 'endpoint', 'action')
    end

    it "passes on options" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => Disqussed::defaults[:api_key],
                         :api_secret => Disqussed::defaults[:secret_key],
                         :pants => "none" })

      Disqussed::Api.request('post', 'endpoint', 'action', { :pants => "none" })
    end

    it "authenticates as the access_token user" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => Disqussed::defaults[:api_key],
                         :api_secret => Disqussed::defaults[:secret_key],
                         :access_token => Disqussed::defaults[:access_token] })

      Disqussed::Api.request('post', 'endpoint', 'action', {}, true)
    end
  end

  describe "get" do
    it "builds a simple Disqus Get Request" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => Disqussed::defaults[:api_key],
                          :api_secret => Disqussed::defaults[:secret_key] })

      Disqussed::Api.request('get', 'endpoint', 'action')
    end

    it "passes on options" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => Disqussed::defaults[:api_key],
                          :api_secret => Disqussed::defaults[:secret_key],
                          :pants => "none" })

      Disqussed::Api.request('get', 'endpoint', 'action', { :pants => "none" })
    end

    it "authenticates as the access_token user" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => Disqussed::defaults[:api_key],
                          :api_secret => Disqussed::defaults[:secret_key],
                          :access_token => Disqussed::defaults[:access_token] })

      Disqussed::Api.request('get', 'endpoint', 'action', {}, true)
    end
  end

  describe "remote_auth_s3" do
    before :each do
      @unix_timestamp = 1347468657
      Time.any_instance.stub(:to_i).and_return(@unix_timestamp)
    end

    it "generates an auth string" do
      data = { :id => 1234, :username => "shlappy", :email => "test@stipple-test.com", :avatar => "linkified", :url => "fanks" }
      encoded = "eyJpZCI6MTIzNCwidXNlcm5hbWUiOiJzaGxhcHB5IiwiZW1haWwiOiJ0ZXN0QHN0aXBwbGUtdGVzdC5jb20iLCJhdmF0YXIiOiJsaW5raWZpZWQiLCJ1cmwiOiJmYW5rcyJ9"
      sha1 = "8c36a31c0082948701b89668ef1cef8ca982ea5f"

      Disqussed::Api.remote_auth_s3(data).should == "#{encoded} #{sha1} #@unix_timestamp"
    end
  end
end