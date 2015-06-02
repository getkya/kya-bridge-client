module KyaBridgeClient
  class PostCollection
    include Enumerable

    def initialize
      @posts = []
    end

    def add(post_result)
      @posts += post_result.posts
    end

    def each(&blk)
      p "each called"
      posts.each(&blk)
    end

    private

    attr_reader :posts
  end
end
