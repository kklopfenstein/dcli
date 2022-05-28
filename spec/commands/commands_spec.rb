# frozen_string_literal: true

RSpec.describe Dcli::Commands do
  describe '#command_for_name' do
    subject { described_class.command_for_name(command_name) }

    context 'command that exists' do
      let(:command_name) { 'create-webhook' }

      it 'returns command class' do
        expect(subject).to eq(Dcli::Commands::CreateWebhook)
      end
    end
  end
end
