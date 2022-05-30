# frozen_string_literal: true

module Dcli
  module Requests
    # Base request class for Discord API call
    class DiscordRequest
      MissingRequiredArgument = Class.new(StandardError)

      BASE_URL = 'https://discord.com/api'

      def initialize(token:)
        @token = token
      end

      def headers
        {
          Authorization: "Bot #{@token}",
          'Content-Type': 'application/json'
        }
      end

      def path
        raise 'Not implemented'
      end

      def method
        raise 'Not implemented'
      end

      def body
        raise 'Not implemented'
      end

      def params
        raise 'Not implemented'
      end

      def run
        request = Typhoeus::Request.new(
          "#{BASE_URL}/#{path}",
          method: method,
          body: body&.to_json,
          params: params,
          headers: headers
        )
        request.run
        request.response
      end
    end
  end
end
