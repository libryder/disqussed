require 'active_support/core_ext/hash'

require 'disqussed/version'
require 'disqussed/api'
require 'disqussed/threads'
require 'disqussed/posts'

module Disqussed
  @defaults = {
    :api_key => "",
    :secret_key => "", # only required if sso is set to true
    :remote_domain => "", # only required if sso is set to true
    :access_token => "",
    :sso => false,
    :developer => false
  }

  def self.defaults
    @defaults
  end
end
