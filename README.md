# Disqussed

A simple wrapper around the Disqus V3 API.

## Installation

Add this line to your application's Gemfile:

    gem 'disqussed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install disqussed

## Usage

Edit the disqussed.rb to add your api_key. Create a thread with Disqussed::Thread.create, create a post with Disqussed::Post.create("message", { :thread => thread_id }).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
