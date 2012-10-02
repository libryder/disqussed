require 'httparty'
require 'digest/sha1'

module Disqussed
  class Api
    ROOT = 'https://disqus.com/api'
    API_VERSION = '3.0'

    class << self
      def request(method, endpoint, action, opts = {}, authenticate_as_self = false, user = {})
        throw "Missing API Key" if Disqussed::defaults[:api_key].nil?

        opts[:api_key] = Disqussed::defaults[:api_key]
        opts[:api_secret] = Disqussed::defaults[:secret_key]

        if authenticate_as_self
          opts[:access_token] = Disqussed::defaults[:access_token]
        elsif Disqussed::defaults[:sso]
          throw "Missing API Secret" if Disqussed::defaults[:secret_key].nil?

          user.slice!(:id, :username, :email, :avatar, :url)

          opts[:remote_auth] = remote_auth_s3(user)
        end

        if method === "post"
          HTTParty.post([ROOT, API_VERSION, endpoint, action + '.json'].join('/'), { :body => opts })
        elsif method === "get"
          HTTParty.get([ROOT, API_VERSION, endpoint, action + '.json'].join('/'), { :query => opts })
        end
      end

      def remote_auth_s3(data)
        digest = OpenSSL::Digest::Digest.new('sha1')
        data = Base64.urlsafe_encode64(MultiJson.dump(data))
        timestamp = Time.now.to_i

        sha1 = OpenSSL::HMAC.hexdigest(digest, Disqussed::defaults[:secret_key], "#{data} #{timestamp}")

        "#{data} #{sha1} #{timestamp}"
      end
    end
  end
end