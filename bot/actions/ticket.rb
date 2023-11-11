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
    when 'reply_yes', 'reply_no'
      # Existing quiz action handling
      response_text = action_id == 'reply_yes' ? "Great! I also think so! :thumbsup:" : "Oops! Try to google it... :thumbsdown:"
      slack_client.chat_postMessage(channel: channel_id, text: response_text)
    when 'create_issue'
      # Handle the create issue action for /ticket
      issue_title = payload["state"]["values"]["ticket_title"]["value"]
      issue_description = payload["state"]["values"]["ticket_description"]["value"]
      create_github_issue(issue_title, issue_description, channel_id, user_id, slack_client)
    end

    nil
  end
end

def create_github_issue(title, description, channel_id, user_id, slack_client)
  github_token = ENV['GITHUB_TOKEN']
  github_repository = ENV['GITHUB_REPOSITORY']

  github_client = Octokit::Client.new(access_token: github_token)

  begin
    issue = github_client.create_issue(github_repository, title, description)
    slack_client.chat_postMessage(channel: channel_id, text: "Hi <@#{user_id}>, your issue has been created: #{issue.html_url}")
  rescue => e
    slack_client.chat_postMessage(channel: channel_id, text: "Sorry <@#{user_id}>, there was an error creating your issue: #{e.message}")
  end
end
