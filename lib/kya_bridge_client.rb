require "kya_bridge_client/version"
require "kya_bridge_client/post_retreiver"

module KyaBridgeClient
  def self.get_posts(domain)
    PostRetreiver.new(domain).call
  end
end
