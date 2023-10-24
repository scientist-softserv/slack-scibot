# frozen_string_literal: true

SlackRubyBotServer::Events.configure do |config|
  config.on :event do |event|
    event.logger.info "Received #{event[:type]}, #{event[:event][:type]}."
    event.logger.debug event.inspect.to_s
    { ok: true }
  end
end
