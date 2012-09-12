module Disqussed
  class Threads
    @@endpoint = 'threads'

    class << self
      def create(forum = nil, title = nil, opts = {})
        opts['forum'] = forum ? forum : Disqussed::defaults[:forum]
        opts['title'] = title

        opts.slice(:api_key, :access_token, :forum, :title)

        Disqussed::Api.request('post', @@endpoint, 'create', opts, true)
      end

      def details(thread = nil)
        opts = {}
        opts['thread'] = thread

        opts.slice(:api_key, :access_token, :thread)

        Disqussed::Api.request('get', @@endpoint, 'details', opts, true)
      end

      def post_count(thread = nil)
        opts = {}
        opts['thread'] = thread

        opts.slice(:api_key, :access_token, :thread)

        details = Disqussed::Api.request('get', @@endpoint, 'details', opts, true)

        details["response"]["posts"]
      end

      def remove(thread = nil)
        opts = {}
        opts['thread'] = thread

        opts.slice(:api_key, :access_token, :thread)

        Disqussed::Api.request('post', @@endpoint, 'remove', opts, true)
      end
    end
  end
end