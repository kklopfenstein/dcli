# frozen_string_literal: true

require 'optparse'

module Dcli
  # dcli command line options parser
  class Options
    TokenRequired = Class.new(StandardError)
    CommandNotFound = Class.new(StandardError)

    attr_accessor :options

    def initialize(argv) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      @options = {}

      @options[:command] = argv[0]
      raise CommandNotFound, "#{argv[0]} command not found." unless Commands::ALL.include?(@options[:command])

      parser = OptionParser.new do |opts|
        opts.banner = 'Usage dcli [options]'

        opts.on('-tTOKEN', '--token TOKEN', 'Discord bot token') do |token|
          @options[:token] = token
        end

        opts.on('-w', '--webhook_id ID', 'Webhook ID') do |id|
          @options[:webhook_id] = id
        end

        opts.on('-c', '--channel_id CHANNEL', 'Channel ID') do |id|
          @options[:channel_id] = id
        end

        opts.on('-n', '--name NAME', 'Name') do |name|
          @options[:name] = name
        end
      end

      parser.parse!(argv)

      raise TokenRequired, 'Token must be specified.' unless @options[:token]
    end
  end
end
