# frozen_string_literal: true

require 'typhoeus'
require 'json'

require 'constants'
require 'commands/base_command'
require 'commands/create_webhook'
require 'commands/get_webhooks'
require 'commands/commands'
require 'dcli/version'
require 'options'
require 'requests/discord_request'
require 'requests/create_webhook'
require 'requests/get_webhooks'

# Base dcli module
module Dcli
  def self.run(argv, output: $stdout)
    options = Options.new(argv).options

    execute_command(options: options, output: output)

    Constants::ExitCodes::SUCCESS
  rescue => e # rubocop:disable Style/RescueStandardError
    output.puts e.message
    Constants::ExitCodes::ERROR
  end

  private_class_method def self.execute_command(options:, output:)
    command = Commands.command_for_name(options[:command]).new(options)
    command.execute(output)
  end
end
