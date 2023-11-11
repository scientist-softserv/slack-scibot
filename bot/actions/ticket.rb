SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions' do |action|
    payload = action[:payload]
    action_id = payload["actions"][0]["action_id"]
    channel_id = payload["channel"]["id"]
    team_id = payload["team"]["id"]
    user_id = payload["user"]["id"]
    action.logger.info "Action #{action_id} has been processed in channel #{channel_id}"
    team = Team.find_by(team_id: team_id)
    slack_client = Slack::Web::Client.new(token: team.token)

    case action_id
    when 'create_issue'
      # Handle the create issue action for /ticket
      issue_title = payload["state"]["values"]["ticket_title"]["value"]
      issue_description = payload["state"]["values"]["ticket_description"]["value"]

      # scibot channel id for now
      channel_id = 'C065NSAGFAM'
      # Go to scibot channel and put the payload there.
      slack_client.chat_postMessage(channel: channel_id, text: "Issue title: #{issue_title}\nIssue description: #{issue_description}")
    end

    nil
  end
end