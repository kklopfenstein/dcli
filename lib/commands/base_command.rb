# frozen_string_literal: true

module Dcli
  module Commands
    class BaseCommand
      CommandFailed = Class.new(StandardError)
    end
  end
end
