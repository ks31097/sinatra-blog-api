# frozen_string_literal: true

require_relative '../helpers/application_helper'

class ApplicationController < Sinatra::Base
  configure do
    helpers ApplicationHelper

    set :views, './app/views'

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

  # @api: Format the json response
  def json_response(code: 200, data: nil)
    status = [200, 201].include?(code) ? 'SUCCESS' : 'FAILED'
    headers['Content-Type'] = 'application/json' # content_type :json

    if data
      [ code, { data: data, message: status }.to_json ]
    end
  end

  # @api: Format the json response db
  def json_response_db(data: nil, message: nil)
    headers['Content-Type'] = 'application/json' # content_type :json

    { data: data, message: message }.to_json
  end

  # api: Format JSON error responses
  def error_response(code, e)
    json_response(code: code, data: { error: e.message })
  end

  # @api: 404
  not_found do
    json_response(code: 404, data: { error: 'The page you are looking for is missing' })
  end
end
