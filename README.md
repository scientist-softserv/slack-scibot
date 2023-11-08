# Slack Rails Bot Starter

This is a boilerplate for building [slack apps](https://api.slack.com/start) with Ruby on Rails.

The default branch `master` uses Mongoid as database adapter. For ActiveRecord, please check [`postgres`](https://github.com/crazyoptimist/slack-rails-bot-starter/tree/postgres) branch.

## Setup

#### Prerequisites

- FQDN(Fully Qualified Domain Name) to host the app publicly. You can also choose to use [ngrok](https://ngrok.com/) instead.

#### Create a new slack app

1. Create a new app [here](https://api.slack.com/apps?new_app=1)
2. Navigate to the **OAuth & Permissions** page and add the following **Bot Token Scopes**:

- `users:read`
- `channels:read`
- `groups:read`
- `chat:write`
- `commands`
- `incoming-webhook`

Slack Link to Slack-Scibot, will need to authenticate via Slack login to the workspace it is configured to work with: https://api.slack.com/apps/A062693KZRB

  **BASE_URL** stands for https://slack-scibot.notch8.cloud hereafter.
  Use **https://slack-scibot.notch8.cloud** for **Redirect**.

3. Activate **Interactivity & Shortcuts** and add this url: `https://slack-scibot.notch8.cloud/api/slack/action`
4. Activate **Slash Commands** adding two slash commands `/ping`, `/quiz` and use this url: `https://slack-scibot.notch8.cloud/api/slack/command`
5. Activate **Event Subscriptions** subscribing to the event type `member_joined_channel` and add this url: `https://slack-scibot.notch8.cloud/api/slack/event`(This step needs the application to be running :D so you can skip this and come back a few mins later)
6. Navigate to the **App Home** page and toggle **Always Show My Bot as Online** (according to your reference)

#### Install dependencies and prepare `.env` file

```bash
bundle install
```

```bash
cp .env.example .env
```

Go to https://api.slack.com/apps, click on your application.
Grab the infomations for `.env` from **Basic Information** section.

## Run the app

```bash
rails s
```

Open **https://slack-scibot.notch8.cloud** in your browser.

## Deployment

Please follow the standard Ruby on Rails application deployment methods.

## License

**MIT**

## TODO

- [ ] Add Rubocop linting
- [ ] Add Specs
- [ ] Add CI/CD with Github Actions
- [ ] Add Contribution Guide

## Credit

This boilerplate was inspired by [Slack Ruby Bot Server](https://github.com/slack-ruby/slack-ruby-bot-server) and [Slack Ruby Bot Server Events](https://github.com/slack-ruby/slack-ruby-bot-server-events).

Thanks to [Daniel Doubrovkine](https://github.com/dblock) and all the contributors.

Made with :heart: by [crazyoptimist](https://github.com/crazyoptimist) :dolphin:
