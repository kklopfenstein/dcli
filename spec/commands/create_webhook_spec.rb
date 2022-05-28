# frozen_string_literal: true

RSpec.describe Dcli::Commands::CreateWebhook do # rubocop:disable Metrics/BlockLength
  describe '#execute' do # rubocop:disable Metrics/BlockLength
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
      allow(response).to receive(:body).and_return('{}')
      subject
    end
  end
end
