module Disqussed
  class Posts
    ENDPOINT = 'posts'

    class << self
      def create(message = nil, opts = {})
        raise "Cannot create post without message" unless message

        opts[:message] = message

        opts.slice(:api_key, :access_token, :thread, :author_email, :author_name, :message)

        Disqussed::Api.post(ENDPOINT, 'create', opts)
      end

      def list(opts = {})
        opts.slice(:api_key, :access_token, :category, :thread, :forum, :since,
          :related, :limit, :offset, :include, :order
        )

        Disqussed::Api.get(ENDPOINT, 'list', opts)
      end
    end
  end
end