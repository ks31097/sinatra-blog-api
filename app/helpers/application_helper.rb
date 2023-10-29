# frozen_string_literal: true

module ApplicationHelper
  # @api: Format the json response
  def json_response(message, status)
    content_type :'application/json'

    { data: message, error: status }.to_json
  end

  def server_time_run
    DateTime.now.strftime('%d-%m-%Y %H:%M')
  end

  def time_now
    Time.now
  end

  # @sinatra-flash errors format
  def sinatra_flash_error(data)
    data.errors.full_messages
  end
end
