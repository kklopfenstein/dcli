# frozen_string_literal: true

RSpec.describe Dcli::Commands::GetWebhooks do
  describe '#execute' do
    subject { described_class.new(options).execute(output) }

    let(:output) { double('stdout') }
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:body) do
      [
        {
          'id' => '1234',
          'guild_id' => 'abc123',
          'token' => 'bvc234'
        },
        {
          'id' => '4321',
          'guild_id' => 'cde123',
          'token' => 'ywf234'
        }
      ].to_json
    end
    let(:options) { { channel_id: 'chan123', token: 'token123' } }

    it 'exeutes request and prints list of webhooks' do
      allow(Dcli::Requests::GetWebhooks).to receive(:new).with(channel_id: 'chan123',
                                                               token: 'token123').and_return(request)
      allow(request).to receive(:run).and_return(response)
      allow(response).to receive(:body).and_return(body)
      allow(response).to receive(:success?).and_return(true)
      allow(output).to receive(:puts)
      expect(output).to receive(:puts).with('Webhook Id: 1234')
      expect(output).to receive(:puts).with('Guild Id: abc123')
      expect(output).to receive(:puts).with('Webhook Token: bvc234')
      expect(output).to receive(:puts).with('Webhook Id: 4321')
      expect(output).to receive(:puts).with('Guild Id: cde123')
      expect(output).to receive(:puts).with('Webhook Token: ywf234')
      expect(subject)
    end
  end
end
