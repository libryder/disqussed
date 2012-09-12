require 'httparty'
#require 'openssl'
#require 'base64'
require 'digest/sha1'

module Disqussed
  class Api
    @@root = 'https://disqus.com/api'
    @@api_version = '3.0'

    class << self
      def post(endpoint, action, opts = {}, authenticate_as_self = false, user = {})
        opts[:api_key] ||= Disqussed::defaults[:api_key]
        throw "Missing API Key" if opts[:api_key].nil?

        if authenticate_as_self
          if Disqussed::defaults[:sso]
            opts.delete :api_key
            opts[:api_secret] = Disqussed::defaults[:secret_key]
          else
            opts[:access_token] ||= Disqussed::defaults[:access_token]
          end
        elsif Disqussed::defaults[:sso]
          user.slice(:id, :username, :email, :avatar, :url)

          opts.delete :api_key
          opts[:api_secret] = Disqussed::defaults[:secret_key]

          opts[:remote_auth] = remote_auth_s3(user)
        end

        HTTParty.post([@@root, @@api_version, endpoint ,action + '.json?'].join('/'), { :body => opts })
      end

      def get(endpoint, action, opts = {}, authenticate_as_self = false, user = {})
        opts[:api_key] ||= Disqussed::defaults[:api_key]
        throw "Missing API Key" if opts[:api_key].nil?

        if authenticate_as_self
          if Disqussed::defaults[:sso]
            opts.delete :api_key
            opts[:api_secret] = Disqussed::defaults[:secret_key]
          else
            opts[:access_token] ||= Disqussed::defaults[:access_token]
          end
        elsif Disqussed::defaults[:sso]
          user.slice(:id, :username, :email, :avatar, :url)

          opts.delete :api_key
          opts[:api_secret] = Disqussed::defaults[:secret_key]

          opts[:remote_auth] = remote_auth_s3(user)
        end

        HTTParty.get([@@root, @@api_version, endpoint ,action + '.json?'].join('/'), { :query => opts })
      end

      def remote_auth_s3(data)
        digest = OpenSSL::Digest::Digest.new('sha1')
        data = Base64.strict_encode64(MultiJson.dump(data))
        timestamp = Time.now.to_i

        sha1 = OpenSSL::HMAC.hexdigest(digest, Disqussed::defaults[:secret_key], "#{data} #{timestamp}")

        "#{data} #{sha1} #{timestamp}"
      end
    end
  end
end