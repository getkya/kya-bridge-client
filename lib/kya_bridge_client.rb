require "kya_bridge_client/version"
require "kya_bridge_client/post_retreiver"
require "kya_bridge_client/post_cursor"
require "kya_bridge_client/api_client"
require "kya_bridge_client/post_result"

module KyaBridgeClient
  def self.get_posts(domain)
    PostRetreiver.new(PostCursor.new(:api_client => ApiClient.new(:domain => domain, :post_result_factory => PostResult.method(:new)))).call
  end
end
