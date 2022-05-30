# frozen_string_literal: true

module Dcli
  module Commands
    # command to get list of webhooks
    class GetWebhooks < BaseCommand
      def initialize(options)
        @options = options
        super()
      end

      def execute(output)
        response = Requests::GetWebhooks.new(
          channel_id: @options[:channel_id],
          token: @options[:token]
        ).run

        raise CommandFailed, 'Request not successful.' unless response.success?

        print(output: output, webhooks: JSON.parse(response.body))
      end

      private

      def print(output:, webhooks:)
        webhooks.each do |webhook|
          output.puts "Webhook Id: #{webhook['id']}"
          output.puts "Guild Id: #{webhook['guild_id']}"
          output.puts "Webhook Token: #{webhook['token']}"
          output.puts "\n"
        end
      end
    end
  end
end
