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

  private

  # @format body data_json
  def data_json(created: false)
    payload = JSON.parse request.body.read
    if created
      payload['created_at'] = time_now
      payload['updated_at'] = time_now
    end
    payload
  end

  def article_id
    params['id'].to_i
  end
end
