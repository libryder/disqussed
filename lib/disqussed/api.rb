require 'httparty'

module Disqussed
  class Api
    @@root = 'https://disqus.com/api'
    @@api_version = '3.0'

    class << self
      def post(endpoint, action, opts = {}, authenticate_as_self = false)
        opts[:api_key] ||= Disqussed::defaults[:api_key]
        throw "Missing API Key" if opts[:api_key].nil?

        if authenticate_as_self
          opts[:access_token] ||= Disqussed::defaults[:access_token]
        end

        HTTParty.post([@@root, @@api_version, endpoint ,action + '.json?'].join('/'), { :body => opts })
      end

      def get(endpoint, action, opts = {}, authenticate_as_self = false)
        opts[:api_key] ||= Disqussed::defaults[:api_key]
        throw "Missing API Key" if opts[:api_key].nil?

        if authenticate_as_self
          opts[:access_token] ||= Disqussed::defaults[:access_token]
        end

        HTTParty.get([@@root, @@api_version, endpoint ,action + '.json?'].join('/'), { :query => opts })
      end
    end
  end
end