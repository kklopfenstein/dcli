# frozen_string_literal: true

RSpec.describe Dcli::Commands::CreateWebhook do
  describe '#execute' do
    subject { described_class.new(options).execute(output) }

    let(:output) { double('output') }
    let(:request) { double('create-webhook') }
    let(:response) { double('request-response') }
    let(:channel_id) { '123' }
    let(:name) { 'name' }
    let(:token) { '1234' }
    let(:options) do
      {
        channel_id: channel_id,
        name: name,
        token: token
      }
    end

    before do
      allow(output).to receive(:puts)
    end

    it 'creates request with correct arguments and runs request' do
      expect(Dcli::Requests::CreateWebhook).to receive(:new).with(
        channel_id: channel_id,
        token: token,
        name: name
      ).and_return(request)
      expect(request).to receive(:run).and_return(response)
      allow(response).to receive(:success?).and_return(true)
      allow(response).to receive(:body).and_return({ 'id' => '123', 'token' => '456', 'guild_id' => 'abc' })
      expect(output).to receive(:puts).with('Webhook Id: 123')
      expect(output).to receive(:puts).with('Guild Id: abc')
      expect(output).to receive(:puts).with('Webhook Token: 456')
      subject
    end

    it 'raises error if request fails' do
      expect(Dcli::Requests::CreateWebhook).to receive(:new).with(
        channel_id: channel_id,
        token: token,
        name: name
      ).and_return(request)
      expect(request).to receive(:run).and_return(response)
      allow(response).to receive(:success?).and_return(false)
      expect { subject }.to raise_error(Dcli::Commands::BaseCommand::CommandFailed)
    end
  end
end
