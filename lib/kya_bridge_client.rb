require "kya_bridge_client/version"
require "kya_bridge_client/post_retreiver"
require "kya_bridge_client/post_cursor"
require "kya_bridge_client/api_client"
require "kya_bridge_client/post_result"
require "kya_bridge_client/post_collection"

module KyaBridgeClient
  def self.get_posts(domain, root="")
    PostRetreiver.new(PostCollection.new, post_cursor_for(domain, root)).call
  end

  private

  def self.post_cursor_for(domain, root)
    PostCursor.new(:api_client => api_client_for(domain, root))
  end

  def self.api_client_for(domain, root)
    ApiClient.new(:domain => domain, :root => root, :post_result_factory => PostResult.method(:new))
  end
end
