SlackRubyBotServer::Events.configure do |config|
  config.on :event, ['event_callback', 'app_mention'] do |event|
    team = Team.find_by(team_id: event[:event][:team]) || raise("Cannot find team with ID #{event[:event][:team]}.")

    event.logger.debug("Received event: #{event.inspect}")
    slack_client = Slack::Web::Client.new(token: team.token)
    text = event[:event][:text]
    event.logger.debug("Text: #{text}")
    event.logger.debug("User: #{event[:authorizations][0][:user_id]}")
    group_name = text.match(/<@#{event[:authorizations][0][:user_id]}> (\w+)/)&.captures&.first
    event.logger.debug("Group name: #{group_name}")
    group = Group.find_by(name: group_name) if group_name
    if group
      message = group.members.map { |m| "<@#{m.member_id || m.handle}>" }.join(', ')
      slack_client.chat_postMessage(channel: event[:event][:channel], text: "^ #{message}", thread_ts: event[:event][:ts])
    end
    { ok: true }
  end
end
