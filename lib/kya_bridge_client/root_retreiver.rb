module KyaBridgeClient
  class RootRetreiver
    def initialize(domain)
      @domain = domain
    end

    def call
      result = possible_paths.find { |path|
        domain_has_kya_on_path?(path)
      }

      if result.nil?
        @domain = domain.gsub("://", "://www.")

        result = possible_paths.find { |path|
          domain_has_kya_on_path?(path)
        }
      end

      result
    end

    private

    attr_reader :domain

    def domain_has_kya_on_path?(path)
      p domain
      p path
      response = connection(domain).get("#{path}/kya-api/present/")
      p response
      p response.body
      response.status != 404 && JSON.parse(response.body).fetch("present")
    rescue JSON::ParserError
      false
    rescue Faraday::ConnectionFailed
      false
    end

    def possible_paths
      [
        "",
        "/blog",
        "/ebass",
      ]
    end

    def connection(domain)
      Faraday::Connection.new(domain) do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.request :url_encoded
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
