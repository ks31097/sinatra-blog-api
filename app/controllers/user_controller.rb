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
    # binding.pry
    status 201

    if sinatra_flash_error(user).length.positive?
      json_response(data: user)
      json_response(sinatra_flash_error(user))
    end
  rescue StandartError
    halt 422, 'Something wrong!'
  end

  # $curl -X POST 127.0.0.1:9292/auth/register -d '{}'
  # @method: log in user using email and password
  post '/auth/login' do
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
  rescue StandartError
    halt 422, 'Something wrong!'
  end
end
