require "json"
require "faraday"

module KyaBridgeClient
  class ApiClient
    def initialize(args)
      @domain              = args.fetch(:domain)
      @post_result_factory = args.fetch(:post_result_factory)
    end

    def posts(params)
      post_result_factory.call(PostApiCall.new(http, params).call)
    end

    private

    attr_reader :domain,  :post_result_factory


    def http
      @http ||= make_http_connection
    end

    def make_http_connection
      Faraday.new(domain) do |conn|
        conn.request :url_encoded
        conn.adapter Faraday.default_adapter
      end
    end

    class PostApiCall
      def initialize(http, params)
        @params = params
        @http = http
      end

      def call
        BackoffState.new.run {
          JSON.parse(get_endpoint_response)
        }
      end

      private

      attr_reader :http, :params

      def get_endpoint_response
        http.get("/kya-api/posts/", params_with_time_header).body
      end

      def params_with_time_header
        params.merge("_" => (Time.now.utc.to_f*1000).to_i)
      end
    end

    class BackoffState
      def initialize(params={})
        @try_count   = params.fetch(:try_count, 10)
        @backoff = params.fetch(:first_sleep, 0.1)
        @growth_factor = params.fetch(:growth_factor, 0.1)
      end

      def run(&blk)
        e = nil
        try_count.times do
          begin
            return blk.call
          rescue
            e = $!
            backoff_and_grow
          end
        end

        raise e
      end

      protected

      attr_reader :try_count, :growth_factor
      attr_accessor :backoff

      private

      def backoff_and_grow
        sleep(backoff)
        grow_backoff
      end

      def grow_backoff
        self.backoff *= (1 + growth_factor)
        self.backoff += rand * growth_factor
      end
    end
  end
end
