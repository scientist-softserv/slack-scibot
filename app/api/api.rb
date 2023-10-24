class Api < Grape::API
  prefix 'api'
  format :json
  mount SlackRubyBotServer::Api::Endpoints::RootEndpoint

  namespace 'admin' do
    http_basic do |username, password|
      username == ENV.fetch('ADMIN_USER', 'scientist') && password == ENV.fetch('ADMIN_PASSWORD', 'softserv')
    end
    resource :groups do
      get do
        Group.all
      end
      post do
        Group.create(name: params[:name])
      end
    end

    resource :members do
      get do
        Member.all
      end
      post do
        Member.create(name: params[:name])
      end
    end

    resource :channel do
      post :join do
        team = Team.find_by!(team_id: params[:team_id])
        slack_client = Slack::Web::Client.new(token: team.token)
        slack_client.conversations_invite(channel: params[:channel_id], users: params[:user_id])
      rescue StandardError => e
        return { status: 200, ok: true } if e.message == 'already_in_channel'

        { status: 500, error: e.message }
      else
        { status: 200, ok: true }
      end
      post :leave do
        team = Team.find_by!(team_id: params[:team_id])
        slack_client = Slack::Web::Client.new(token: team.token)
        slack_client.conversations_kick(channel: params[:channel_id], user: params[:user_id])
      rescue StandardError => e
        return { status: 200, ok: true } if e.message == 'already_in_channel'

        { status: 500, error: e.message }
      else
        { status: 200, ok: true }
      end
    end
  end
end
