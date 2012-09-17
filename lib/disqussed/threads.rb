module Disqussed
  class Threads
    ENDPOINT = 'threads'

    class << self
      def create(forum = nil, title = nil, opts = {})
        opts[:forum] = forum ? forum : Disqussed::defaults[:forum]
        opts[:title] = title

        opts.slice!(:forum, :title)

        Disqussed::Api.request('post', ENDPOINT, 'create', opts, true)
      end

      def details(thread = nil)
        opts = {}
        opts[:thread] = thread

        opts.slice!(:thread)

        Disqussed::Api.request('get', ENDPOINT, 'details', opts, true)
      end

      def post_count(thread = nil)
        opts = {}
        opts[:thread] = thread

        opts.slice!(:thread)

        details = Disqussed::Api.request('get', ENDPOINT, 'details', opts, true)

        details["response"]["posts"]
      end

      def remove(thread = nil)
        opts = {}
        opts[:thread] = thread

        opts.slice!(:thread)

        Disqussed::Api.request('post', ENDPOINT, 'remove', opts, true)
      end
    end
  end
end