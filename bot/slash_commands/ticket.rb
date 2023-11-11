def ticket_message(channel_id)
  {
    channel: channel_id,
    "blocks": [
      {
        "type": "section",
        "text": {
          "type": "plain_text",
          "text": "Please enter the title of the issue:",
          "emoji": true
        }
      },
      {
        "type": "input",
        "element": {
          "type": "plain_text_input",
          "action_id": "ticket_title"
        },
        "label": {
          "type": "plain_text",
          "text": "Title",
          "emoji": true
        }
      },
      {
        "type": "section",
        "text": {
          "type": "plain_text",
          "text": "Please enter the description of the issue:",
          "emoji": true
        }
      },
      {
        "type": "input",
        "element": {
          "type": "plain_text_input",
          "multiline": true,
          "action_id": "ticket_description"
        },
        "label": {
          "type": "plain_text",
          "text": "Description",
          "emoji": true
        }
      },
      {
        "type": "actions",
        "elements": [
          {
            "type": "button",
            "text": {
              "type": "plain_text",
              "text": "Create Issue",
              "emoji": true
            },
            "value": "create_issue",
            "action_id": "create_issue"
          }
        ]
      }
    ]
  }
end

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/ticket' do |command|
    p command
    team_id = command[:team_id]
    channel_id = command[:channel_id]
    command.logger.info "Someone started a ticket creation in channel #{channel_id}."
    team = Team.find_by(team_id: team_id)
    slack_client = Slack::Web::Client.new(token: team.token)
    slack_client.chat_postMessage(ticket_message(channel_id))
    nil
  end
end
