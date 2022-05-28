# frozen_string_literal: true

module Dcli
  module Requests
    # request for creating a webhook
    class CreateWebhook < DiscordRequest
      def initialize(channel_id:, token:, name:)
        raise MissingRequiredArgument, 'Missing channel_id' unless channel_id
        raise MissingRequiredArgument, 'Missing name' unless name

        @channel_id = channel_id
        @name = name

        super(token: token)
      end

      def path
        "channels/#{@channel_id}/webhooks"
      end

      def method
        :post
      end

      def body
        {
          'name': @name
        }
      end

      def params
        {}
      end
    end
  end
end
