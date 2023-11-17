# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/user_helper'
require_relative '../models/user'

class UserController < ApplicationController
  configure do
    helpers UserHelper
  end

  # @method: Create a new user
  post '/auth/register/?' do
    user = User.create(json_user_data(created: true))

    json_response(user, sinatra_flash_error(user)) if sinatra_flash_error(user).length.positive?
    status 201
  end

  # @method: log in user
  post '/auth/login' do
    redirect to(new_url('/info')), 307
    payload = json_user_data # payload['email'], payload['password']

    user = User.find_by(email: payload['email'])

    if user&.authenticate(payload['password'])
      headers \
        body 'Access!'
    else
      status 204
      headers \
        body 'Your email/password combination is not correct!'
    end
  end

  get '/info' do
    body "Method 'Log_in' will be added in fuature updates"
  end
end
