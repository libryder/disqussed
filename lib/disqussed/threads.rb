module Disqussed
  class Threads
    @@endpoint = 'threads'

    class << self
      def create(forum = nil, title = nil, opts = {})
        opts['forum'] = forum
        opts['title'] = title

        opts.slice(:api_key, :access_token, :forum, :title)

        Disqussed::Api.post(@@endpoint, 'create', opts, true)
      end

      def details(thread = nil)
        opts = {}
        opts['thread'] = thread

        opts.slice(:api_key, :access_token, :thread)

        Disqussed::Api.get(@@endpoint, 'details', opts, true)
      end

      def post_count(thread = nil)
        opts = {}
        opts['thread'] = thread

        opts.slice(:api_key, :access_token, :thread)

        details = Disqussed::Api.get(@@endpoint, 'details', opts, true)

        details["response"]["posts"]
      end

      def remove(thread = nil)
        opts = {}
        opts['thread'] = thread

        opts.slice(:api_key, :access_token, :thread)

        Disqussed::Api.post(@@endpoint, 'remove', opts, true)
      end
    end
  end
end