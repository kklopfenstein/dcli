# frozen_string_literal: true

module Dcli
  module Commands
    # create webhook command
    class CreateWebhook < BaseCommand
      def initialize(options)
        @options = options
        super()
      end

      def execute(output)
        response = Requests::CreateWebhook.new(
          channel_id: @options[:channel_id],
          name: @options[:name],
          token: @options[:token]
        ).run

        raise CommandFailed, 'Request not successful.' unless response.success?

        output.puts "Webhook Id: #{response.body['id']}"
        output.puts "Guild Id: #{response.body['guild_id']}"
        output.puts "Webhook Token: #{response.body['token']}"
      end
    end
  end
end
