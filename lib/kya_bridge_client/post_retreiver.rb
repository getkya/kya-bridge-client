module KyaBridgeClient
  class PostRetreiver
    def initialize(post_cursor)
      @post_cursor = post_cursor
    end

    def call
      result = []
      loop do
        result += post_cursor.next_posts
        break unless post_cursor.has_more_posts?
      end

      result
    end

    private

    attr_reader :post_cursor
  end
end
