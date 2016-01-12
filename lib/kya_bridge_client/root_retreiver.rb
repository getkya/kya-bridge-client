module KyaBridgeClient
  class RootRetreiver
    def initialize(domain)
      @domain = domain
    end

    def call
      possible_paths.find { |path|
        domain_has_kya_on_path?(path)
      }
    end

    private

    attr_reader :domain

    def domain_has_kya_on_path?(path)
      response = connection(domain).get("#{path}/kya-api/present/")
      begin
        response.status != 404 && JSON.parse(response.body).fetch("present")
      rescue JSON::ParserError
        false
      end
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
        conn.request :url_encoded
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
