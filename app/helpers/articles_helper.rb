# frozen_string_literal: true

module ArticlesHelper
  # @find all articles
  def find_articles
    Article.all
  end

  # @find the article
  def find_article
    Article.find(article_id)
  end

  def response_message(find_data)
    find_data.as_json

    content_type 'text/plain'
    return 'Perform any pending database migrations!' unless database_exists('articles')
    return 'No articles have been created yet!' unless find_data.length.positive?
  end

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

  def type
    @type ||= accepted_media_type
  end

  def send_data(data = {})
    if type == 'json'
      content_type 'application/json'
      data[:json].call.to_json if data[:json]
    elsif type == 'xml'
      content_type 'application/xml'
      Gyoku.xml(data[:xml].call) if data[:xml]
    end
  end

  private

  # @format body data_json
  def data_json(created: false)
    payload = JSON.parse request.body.read
    if created
      payload['created_at'] ||= time_now
      payload['updated_at'] = time_now
    end
    payload
  end

  def article_id
    params['id'].to_i
  end
end
