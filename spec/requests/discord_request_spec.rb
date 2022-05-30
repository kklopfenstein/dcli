# frozen_string_literal: true

RSpec.describe Dcli::Requests::DiscordRequest do
  describe '#headers' do
    subject { described_class.new(token: token) }

    let(:token) { '1234' }

    let(:expected_headers) do
      {
        Authorization: "Bot #{token}",
        'Content-Type': 'application/json'
      }
    end

    it 'has correct headers' do
      expect(subject.headers).to eq(expected_headers)
    end
  end

  describe '#run' do
    subject { clazz.run }

    let(:token) { 'token' }
    let(:request_path) { 'test' }
    let(:request_body) do
      {
        test: '123'
      }
    end
    let(:request_params) do
      {
        param1: 'value1'
      }
    end

    let(:clazz) do
      Class.new(Dcli::Requests::DiscordRequest) do
        def path
          'test'
        end

        def method
          :get
        end

        def body
          {
            test: '123'
          }
        end

        def params
          {
            param1: 'value1'
          }
        end
      end.new(token: token)
    end
    let(:request) { double('request') }
    let(:response) { {} }

    it 'returns response' do
      expect(Typhoeus::Request).to receive(:new).with(
        "#{described_class::BASE_URL}/#{request_path}",
        method: clazz.method,
        body: clazz.body.to_json,
        params: clazz.params,
        headers: clazz.headers
      ).and_return(request)
      expect(request).to receive(:run)
      expect(request).to receive(:response).and_return(response)
      expect(subject).to eq(response)
    end
  end
end
