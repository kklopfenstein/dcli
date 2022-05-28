# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dcli::Options do # rubocop:disable Metrics/BlockLength
  subject { described_class.new(argv) }

  let(:token) { 'abc123' }
  let(:command_name) { 'create-webhook' }
  let(:webhook_id) { 'webhook-id' }
  let(:channel_id) { 'channel-id' }
  let(:name) { 'some-name' }
  let(:argv) do
    [
      command_name,
      "--token=#{token}",
      "--webhook_id=#{webhook_id}",
      "--channel_id=#{channel_id}",
      "--name=#{name}"
    ]
  end

  it 'returns arguments' do
    expect(subject.options[:token]).to eq(token)
    expect(subject.options[:webhook_id]).to eq(webhook_id)
    expect(subject.options[:channel_id]).to eq(channel_id)
    expect(subject.options[:name]).to eq(name)
  end

  context 'no token argument' do
    let(:argv) { [command_name] }

    it 'raises error if token not present' do
      expect { subject }.to raise_error(described_class::TokenRequired)
    end
  end
end
