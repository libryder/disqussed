require 'httparty'

module Disqussed
  class Api
    ROOT = 'https://disqus.com/api'
    API_VERSION = '3.0'

    class << self
      def post(endpoint, action, opts = {}, authenticate_as_self = false)
        opts[:api_key] ||= Disqussed::defaults[:api_key]

        if authenticate_as_self
          opts[:access_token] ||= Disqussed::defaults[:access_token]
        end

        HTTParty.post([ROOT, API_VERSION, endpoint ,action + '.json?'].join('/'), { :body => opts })
      end

      def get(endpoint, action, opts = {}, authenticate_as_self = false)
        opts[:api_key] ||= Disqussed::defaults[:api_key]

        if authenticate_as_self
          opts[:access_token] ||= Disqussed::defaults[:access_token]
        end

        HTTParty.get([ROOT, API_VERSION, endpoint ,action + '.json?'].join('/'), { :query => opts })
      end
    end
  end
end