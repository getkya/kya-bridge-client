require "spec_helper"
require "kya_bridge_client/post_result"

module KyaBridgeClient
  RSpec.describe PostResult do
    subject(:result) { PostResult.new(post_result_hash) }

    let(:post_result_hash) {
      {
        "posts" => {
          "more" => more,
          "posts" => posts,
        }
      }
    }

    let(:posts) { double(:posts) }

    let(:more) { double(:more_posts) }

    describe "#posts" do
      it "returns the posts array" do
        expect(result.posts).to eq(posts)
      end
    end

    describe "#more_posts?" do
      it "returns the more posts result" do
        expect(result.more_posts?).to eq(more)
      end
    end
  end
end
