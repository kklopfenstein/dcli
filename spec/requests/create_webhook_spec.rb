# frozen_string_literal: true

RSpec.describe Dcli::Requests::CreateWebhook do
  describe '#run' do
    subject { described_class.new(channel_id: channel_id, token: token, name: name).run }

    let(:name) { 'test' }
    let(:channel_id) { '1234' }
    let(:response) do
      Typhoeus::Response.new(
        code: 200,
        body: {
          'id' => '123',
          'guild_id' => '456',
          'token' => 'abc123'
        }.to_json
      )
    end
    let(:token) { 'abc123' }

    before do
      Typhoeus.stub(%r{channels/1234/webhooks}).and_return(response)
    end

    it 'calls Typhoeus' do
      expect(Typhoeus::Request).to receive(:new).with(
        "#{Dcli::Requests::DiscordRequest::BASE_URL}/channels/#{channel_id}/webhooks",
        method: :post,
        body: { name: name }.to_json,
        params: {},
        headers: {
          Authorization: "Bot #{token}",
          'Content-Type': 'application/json'
        }
      ).and_call_original
      expect(subject).to eq(response)
    end
  end
end
