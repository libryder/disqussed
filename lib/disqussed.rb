require 'disqussed/version'
require 'disqussed/api'
require 'disqussed/threads'
require 'disqussed/posts'
require 'active_support/core_ext/hash'

module Disqussed
  @defaults = {
    :api_key => "",
    :secret_key => "", # only required if sso is set to true
    :forum => "",
    :access_token => "",
    :sso => false,
    :developer => false
  }

  def self.defaults
    @defaults
  end
end
