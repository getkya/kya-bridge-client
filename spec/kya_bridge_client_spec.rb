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

  describe ".get_root_for_domain" do
    let(:wordpress_details) {
      {
        :use_ssl => use_ssl,
        :domain => domain,
        :port => port,
      }
    }

    context "for besttechie.com" do
      let(:domain)  { "besttechie.com" }
      let(:port)    { 443 }
      let(:use_ssl) { true }

      it "returns ''" do
        expect(KyaBridgeClient.get_root_for_domain(wordpress_details)).to eq("")
      end
    end

    context "for www.bestbassgear.com", :pending => "bestbassgear comes back" do
      let(:domain)  { "www.bestbassgear.com" }
      let(:port)    { 80 }
      let(:use_ssl) { false }

      it "returns '/ebass'" do
        expect(KyaBridgeClient.get_root_for_domain(wordpress_details)).to eq("/ebass")
      end
    end

    context "for samphippen.com" do

      let(:domain)  { "samphippen.com" }
      let(:port)    { 80 }
      let(:use_ssl) { false }

      it "returns nil" do
        expect(KyaBridgeClient.get_root_for_domain(wordpress_details)).to eq(nil)
      end
    end
  end
end
