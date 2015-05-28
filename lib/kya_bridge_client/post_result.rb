module KyaBridgeClient
  class PostResult
    def initialize(data)
      @posts = data.fetch("posts").fetch("posts")
      @more_posts = data.fetch("posts").fetch("more")
    end

    def posts
      @posts
    end

    def more_posts?
      @more_posts
    end
  end
end
