require 'active_support/core_ext/hash'

require 'disqussed/version'
require 'disqussed/api'
require 'disqussed/threads'
require 'disqussed/posts'

module Disqussed
  @defaults = {
    :api_key => "DwwALtvEas5hYiPZN77Va80fD74tPzxJ8uCj1Iatdon3XkcA7GIbL7Ty7hSbaM0X",
    :access_token => "671388dfed0144e59ebfe9fe401bb832",
    :developer => false
  }

  def self.defaults
    @defaults
  end
end
