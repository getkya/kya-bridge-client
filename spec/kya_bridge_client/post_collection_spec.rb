require "spec_helper"
require "kya_bridge_client/post_collection"

module KyaBridgeClient
  RSpec.describe PostCollection do
    subject(:collection) { PostCollection.new }

    let(:post_result) { double(:post_result, :posts => posts) }

    let(:posts) { [double(:posts)] }


    it "allows you to each added posts" do
      collection.add(post_result)
      expect(collection.each.to_a).to eq(posts)
    end
  end
end
