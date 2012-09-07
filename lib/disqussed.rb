require 'active_support/core_ext/hash'

require 'disqussed/version'
require 'disqussed/api'
require 'disqussed/threads'
require 'disqussed/posts'

module Disqussed
  @defaults = {
    :api_key => "",
    :access_token => "",
    :developer => false
  }

  def self.defaults
    @defaults
  end
end
