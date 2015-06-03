module KyaBridgeClient
  class PostCursor
    def initialize(args)
      @api_client = args.fetch(:api_client)
      @page_number = 0
    end

    def next_posts
      @post_result = api_client.posts(:page => page_number).tap {
        increment_page_number!
      }
    end

    def has_more_posts?
      post_result.more_posts?
    end

    private

    attr_reader :api_client, :post_result, :page_number

    def increment_page_number!
      @page_number += 1
    end
  end
end
