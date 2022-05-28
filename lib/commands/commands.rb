# frozen_string_literal: true

module Dcli
  # Dcli commands
  module Commands
    ALL = [
      CREATE_WEBHOOK = 'create-webhook'
    ].freeze

    COMMAND_CLASSES = {
      CREATE_WEBHOOK => CreateWebhook
    }.freeze

    def self.command_for_name(name)
      COMMAND_CLASSES[name]
    end
  end
end
