# frozen_string_literal: true

require_relative '../helpers/application_helper'
require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    helpers ApplicationHelper

    # __FILE__ is the current file
    set :root, File.dirname(__FILE__)

    register Sinatra::ActiveRecordExtension
    set :database_file, '../../config/database.yml'

    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    enable :sessions

    use Rack::Protection

    register Sinatra::Flash
  end

  configure :development do
    register Sinatra::Reloader
  end

  # @method: Display a small welcome message
  get '/hello' do
    "The server is up and running! The current time: #{server_time_run}"
  end

  # @api: 404
  not_found do
    json_response('The page you are looking for is missing!', 404)
  end
end
