# frozen_string_literal: true

RSpec.describe Dcli::Requests::CreateWebhook do
  describe '#run' do
    subject { described_class.new(channel_id: channel_id, token: token, name: name).run }

    let(:name) { 'test' }
    let(:channel_id) { '1234' }
    let(:response) { double('response') }
    let(:request) { double('request') }
    let(:token) { 'abc123' }

    before do
      allow(request).to receive(:run)
      allow(request).to receive(:response).and_return(response)
    end

    it 'calls Typhoeus' do
      expect(Typhoeus::Request).to receive(:new).with(
        "#{Dcli::Requests::DiscordRequest::BASE_URL}/channels/#{channel_id}/webhooks",
        method: :post,
        body: { 'name': name }.to_json,
        params: {},
        headers: {
          "Authorization": "Bot #{token}",
          "Content-Type": 'application/json'
        }
      ).and_return(request)
      expect(subject).to eq(response)
    end
  end
end
