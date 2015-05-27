require 'spec_helper'

describe KyaBridgeClient do
  it 'has a version number' do
    expect(KyaBridgeClient::VERSION).not_to be nil
  end

  describe ".get_posts" do
    it "retrieves all posts for a domain" do
      expect(KyaBridgeClient.get_posts("http://localdocker.dev:8000").count).to be 13
    end
  end
end
