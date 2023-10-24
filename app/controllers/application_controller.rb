# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: 'scientist', password: ENV.fetch('HTTP_BASIC_PASSWORD', 'softserv')
end
