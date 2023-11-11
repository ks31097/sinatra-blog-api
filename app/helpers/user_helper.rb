# frozen_string_literal: true

module UserHelper
  def new_url(url)
    url
  end

  private

  # @helper: parse user JSON data
  def json_user_data(created: false)
    payload = JSON.parse request.body.read
    if created
      payload['password_digest'] = BCrypt::Password.create(payload['password_digest'])
      payload['created_at'] = time_now
      payload['updated_at'] = time_now
    end
    payload
  end
end
