require "json"
require "faraday"

module KyaBridgeClient
  class ApiClient
    def initialize(args)
      @domain              = args.fetch(:domain)
      @post_result_factory = args.fetch(:post_result_factory)
    end

    def posts(params)
      post_result_factory.call(JSON.parse(http.get("/kya-api/posts/", params).body))
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
  end
end
