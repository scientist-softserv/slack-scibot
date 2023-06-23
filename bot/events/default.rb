
SlackRubyBotServer::Events.configure do |config|
  config.on :event do |event|
    event.logger.info "Received #{event[:type]}, #{event[:event][:type]}."
    event.logger.debug "#{event.inspect}"
    { ok: true }
  end
end
