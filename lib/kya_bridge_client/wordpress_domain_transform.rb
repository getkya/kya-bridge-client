module KyaBridgeClient
  class WordpressDomainTransform
    def initialize(wordpress_details)
      @wordpress_details = wordpress_details
    end

    def domain_with_scheme
      [
        wordpress_details.fetch(:use_ssl) ? "https" : "http",
        "://",
        domain_without_scheme,
      ].join("")
    end

    def domain_without_scheme
      [
        wordpress_details.fetch(:domain),
        ":",
        wordpress_details.fetch(:port).to_s,
      ].join("")
    end

    private

    attr_reader :wordpress_details
  end
end
