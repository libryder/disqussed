module Disqussed
  class Posts
    ENDPOINT = 'posts'

    class << self
      def create(message = nil, opts = {}, user = {})
        opts[:message] = message

        opts.slice(:api_key, :access_token, :thread, :author_email, :author_name, :message)

        Disqussed::Api.request('post', ENDPOINT, 'create', opts, false, user)
      end

      def list(opts = {})
        opts.slice(:api_key, :access_token, :category, :thread, :forum, :since,
          :related, :limit, :offset, :include, :order
        )

        Disqussed::Api.request('get', ENDPOINT, 'list', opts, false)
      end
    end
  end
end