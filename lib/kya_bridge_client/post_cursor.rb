module KyaBridgeClient
  class PostCursor
    def initialize(args)
      @api_client = args.fetch(:api_client)
    end

    def next_posts
      @post_result = api_client.posts(:page => 0)
    end

    def has_more_posts?
      post_result.more_posts?
    end

    private

    attr_reader :api_client, :post_result
  end
end
