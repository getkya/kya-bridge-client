require "spec_helper"

module KyaBridgeClient
  RSpec.describe PostCursor do
    subject(:cursor) {
      PostCursor.new(
        :api_client => api_client,
      )
    }

    let(:api_client) { double(:api_client, :posts => posts_result) }
    let(:posts_result) { double(:posts_result, :more_posts? => more_posts) }
    let(:more_posts) { false }


    describe "#next_posts" do
      context "first call" do
        it "it sends a request for page zero" do
          cursor.next_posts
          expect(api_client).to have_received(:posts).with(:page => 0)
        end
      end

      context "second call" do
        it "sends a request for page 1" do
          cursor.next_posts
          cursor.next_posts
          expect(api_client).to have_received(:posts).with(:page => 1)
        end
      end
    end

    describe "#has_more_posts?" do
      context "when there are more posts" do
        let(:more_posts) { true }

        it "returns true" do
          cursor.next_posts
          expect(cursor.has_more_posts?).to be true
        end
      end

      context "when there aren't more posts" do
        let(:more_posts) { false }

        it "returns false" do
          cursor.next_posts
          expect(cursor.has_more_posts?).to be false
        end
      end
    end
  end
end
