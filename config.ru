# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# Requires Slack Bot Actions

require_relative 'bot/slash_commands'
require_relative 'bot/events'
require_relative 'bot/actions'

SlackRubyBotServer::App.instance.prepare!

run Rails.application
