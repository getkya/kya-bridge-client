module KyaBridgeClient
  class PostRetreiver
    def initialize(post_collection, post_cursor)
      @post_collection = post_collection
      @post_cursor = post_cursor
    end

    def call
      loop do
        post_collection.add(post_cursor.next_posts)
        break unless post_cursor.has_more_posts?
      end

      post_collection
    end

    private

    attr_reader :post_cursor, :post_collection
  end
end
