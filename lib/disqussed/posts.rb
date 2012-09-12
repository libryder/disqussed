module Disqussed
  class Posts
    @@endpoint = 'posts'

    class << self
      def create(message = nil, opts = {}, user = {})
        opts[:message] = message

        opts.slice(:api_key, :access_token, :thread, :author_email, :author_name, :message)

        Disqussed::Api.post(@@endpoint, 'create', opts, false, user)
      end

      def list(opts = {})
        opts.slice(:api_key, :access_token, :category, :thread, :forum, :since,
          :related, :limit, :offset, :include, :order
        )

        Disqussed::Api.get(@@endpoint, 'list', opts, false)
      end
    end
  end
end