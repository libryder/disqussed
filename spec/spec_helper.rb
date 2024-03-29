require "rubygems"
require "bundler"
require "vcr"
require "fakeweb"
require "multi_json"
require "cgi"

$:.push File.expand_path("../lib", __FILE__)
require "disqussed"

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path("fixtures/vcr_cassettes", File.dirname(__FILE__))
  c.hook_into :fakeweb
  c.filter_sensitive_data('<API_KEY>') { Disqussed::defaults[:api_key] }
  c.filter_sensitive_data('<SECRET_KEY>') { Disqussed::defaults[:secret_key] }
  c.filter_sensitive_data('<ACCESS_TOKEN>') { Disqussed::defaults[:access_token] }
  c.filter_sensitive_data('<FORUM_NAME>') { Disqussed::defaults[:forum] }

  # For post requests
  c.filter_sensitive_data('<AUTH_S3>') do |interaction|
    params = CGI::parse(interaction.request.body)

    CGI::escape(params["remote_auth"].first).gsub('+', '%20') unless params["remote_auth"].first.nil?
  end

  # For get requests
  c.filter_sensitive_data('<AUTH_S3>') do |interaction|
    params = CGI::parse(interaction.request.uri)

    CGI::escape(params["remote_auth"].first).gsub('+', '%20') unless params["remote_auth"].first.nil?
  end

  c.allow_http_connections_when_no_cassette = false
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  config.extend VCR::RSpec::Macros
end
