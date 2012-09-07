require 'httparty'
require 'openssl'
require 'base64'

module Disqussed
  class Api
    @@root = 'https://disqus.com/api'
    @@api_version = '3.0'

    DIGEST = OpenSSL::Digest::Digest.new('sha1')

    class << self
      def post(endpoint, action, opts = {}, authenticate_as_self = false, user = {})
        opts[:api_key] ||= Disqussed::defaults[:api_key]
        throw "Missing API Key" if opts[:api_key].nil?

        if authenticate_as_self
          opts[:access_token] ||= Disqussed::defaults[:access_token]
        elsif Disqussed::defaults[:sso]
          return unless user.has_key?(id) and user.has_key?(username) and user.has_key?(email)

          user.slice!(:id, :username, :email, :avatar, :url)

          opts[:user] = "remote:#{Disqussed::defaults[:remote_domain]}-#{hmac_sha1(user)}"
        end

        HTTParty.post([@@root, @@api_version, endpoint ,action + '.json?'].join('/'), { :body => opts })
      end

      def get(endpoint, action, opts = {}, authenticate_as_self = false)
        opts[:api_key] ||= Disqussed::defaults[:api_key]
        throw "Missing API Key" if opts[:api_key].nil?

        if authenticate_as_self
          opts[:access_token] ||= Disqussed::defaults[:access_token]
        elsif Disqussed::defaults[:sso]
          return unless user.has_key?(id) and user.has_key?(username) and user.has_key?(email)

          user.slice!(:id, :username, :email, :avatar, :url)

          opts[:user] = "remote:#{Disqussed::defaults[:remote_domain]}-#{hmac_sha1(user)}"
        end

        HTTParty.get([@@root, @@api_version, endpoint ,action + '.json?'].join('/'), { :query => opts })
      end

      def hmac_sha1(data)
        timestamp = Time.now.to_i
        data = MultiJson.dumps(data)

        OpenSSL::HMAC.digest(DIGEST, Disqussed::defaults[:secret_key], "#{data} #{timestamp}").chomp
      end
    end
  end
end