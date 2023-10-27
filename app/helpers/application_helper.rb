# frozen_string_literal: true

module ApplicationHelper
  def json_or_default?(type)
    ['application/json', 'application/*', '*/*'].include?(type.to_s)
  end

  def xml?(type)
    type.to_s == 'application/xml'
  end

  def accepted_media_type
    return 'json' unless request.accept.any?

    request.accept.each do |type|
      return 'json' if json_or_default?(type)
      return 'xml' if xml?(type)
    end

    content_type 'text/plain'
    halt 406, 'application/json, application/xml'
  end

  # @api: Format the json response
  def json_response(message)
    { data: message }.to_json
  end

  def server_time_run
    DateTime.now.strftime('%d-%m-%Y %H:%M')
  end

  def time_now
    Time.now
  end

  # @sinatra-flash errors format
  def sinatra_flash_error(object)
    object.errors.full_messages
  end
end
