# frozen_string_literal: true

module Dcli
  module Requests
    # request for getting webhook information
    class GetWebhooks < DiscordRequest
      def initialize(token:, channel_id:)
        raise MissingRequiredArgument, 'Missing channel_id' unless channel_id

        @channel_id = channel_id

        super(token: token)
      end

      def path
        "channels/#{@channel_id}/webhooks"
      end

      def method
        :get
      end

      def body
        nil
      end

      def params
        nil
      end
    end
  end
end
