require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Api do
  describe "post" do
    it "builds a simple Disqus Post Request" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => Disqussed::defaults[:api_key] })

      Disqussed::Api.post('endpoint', 'action')
    end

    it "overrides the api_key" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => "google" })

      Disqussed::Api.post('endpoint', 'action', { :api_key => "google" })
    end

    it "passes on options" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => Disqussed::defaults[:api_key], :pants => "none" })

      Disqussed::Api.post('endpoint', 'action', { :pants => "none" })
    end

    it "authenticates as the access_token user" do
      HTTParty
        .should_receive(:post)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :body => { :api_key => Disqussed::defaults[:api_key],
                         :access_token => Disqussed::defaults[:access_token] })

      Disqussed::Api.post('endpoint', 'action', {}, true)
    end
  end

  describe "get" do
    it "builds a simple Disqus Get Request" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => Disqussed::defaults[:api_key] })

      Disqussed::Api.get('endpoint', 'action')
    end

    it "overrides the api_key" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => "google" })

      Disqussed::Api.get('endpoint', 'action', { :api_key => "google" })
    end

    it "passes on options" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => Disqussed::defaults[:api_key], :pants => "none" })

      Disqussed::Api.get('endpoint', 'action', { :pants => "none" })
    end

    it "authenticates as the access_token user" do
      HTTParty
        .should_receive(:get)
        .with("https://disqus.com/api/3.0/endpoint/action.json?",
              :query => { :api_key => Disqussed::defaults[:api_key],
                         :access_token => Disqussed::defaults[:access_token] })

      Disqussed::Api.get('endpoint', 'action', {}, true)
    end
  end
end