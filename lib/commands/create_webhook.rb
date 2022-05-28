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

        output.puts response.success?
        output.puts response.body
      end
    end
  end
end
