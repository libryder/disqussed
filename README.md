# Disqussed

A simple wrapper around the Disqus V3 API.

## Installation

Add this line to your application's Gemfile:

    gem 'disqussed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install disqussed

## Configuration

Edit lib/disqussed.rb and add your api_key and access_token. These can be found on the application page for your app
by going to http://disqus.com/api/applications and choosing your application.

## Usage

### Threads

#### Create

Required - forum, title

Options - none

    Disqussed::Threads.create(forum, title)

#### Remove

Required - thread

Options - none

    Disqussed::Threads.remove(thread)

### Posts

#### Create

Required - message

Options - thread, author_email, author_name,

    Disqussed::Post.create("message", { :thread => thread }).

#### List

Required - none
Options - category, thread, forum, since, related, limit, offset, include, order

    Disqussed::Post.list({ :thread => thread })

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
