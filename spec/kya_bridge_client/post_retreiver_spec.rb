require "spec_helper"
require "spec_helper"

module KyaBridgeClient
  RSpec.describe PostRetreiver do
    subject(:retreiver) { PostRetreiver.new(post_collection, post_cursor) }

    let(:post_cursor) {
      double(
        :post_cursor,
        :next_posts => next_posts,
        :has_more_posts? => has_more_posts?,
      )
    }

    let(:post_collection) { double(:post_collection, :add => nil) }

    let(:next_posts)      { double(:posts) }
    let(:has_more_posts?) { false }

    describe "#call" do
      context "with no more posts" do

        it "fetches the posts from the post cursor" do
          retreiver.call
          expect(post_cursor).to have_received(:next_posts)
        end

        it "returns the post collection" do
          expect(retreiver.call).to eq(post_collection)
        end

        it "joins the posts into a post collection" do
          retreiver.call
          expect(post_collection).to have_received(:add).with(next_posts)
        end
      end

      describe "with more posts" do
        before do
          allow(post_cursor).to receive(:has_more_posts?).and_return(true, false)
        end

        it "fetches the posts each time" do
          retreiver.call
          expect(post_cursor).to have_received(:next_posts).exactly(2).times
        end

        it "joins the posts each time" do
          retreiver.call
          expect(post_collection).to have_received(:add).exactly(2).times
        end
      end
    end
  end
end
