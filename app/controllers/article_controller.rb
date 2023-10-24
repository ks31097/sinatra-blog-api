# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/articles_helper'
require_relative '../models/article'

class ArticleController < ApplicationController
  configure do
    helpers ArticlesHelper
  end

  # @method: Display all articles
  get '/articles/?' do
    type = accepted_media_type

    if type == 'json'
      content_type 'application/json'
      json_response(response_message(find_articles))
    elsif type == 'xml'
      content_type 'application/xml'
      Gyoku.xml(articles: response_message(find_articles))
    end
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method: Display the article
  get '/articles/:id/?' do
    type = accepted_media_type

    if type == 'json'
      content_type 'application/json'
      json_response(data: find_article)
    elsif type == 'xml'
      content_type 'application/xml'
      Gyoku.xml(article: find_article)
    end
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method: Receiving back information from the GET request by the client
  head '/articles/?' do
    type = accepted_media_type

    if type == 'json'
      content_type 'application/json'
    elsif type == 'xml'
      content_type 'application/xml'
    end
  end

  # @method: Add a new article to the DB
  post '/articles/?' do
    article = Article.create(data_json(created: true))
    url = "http://localhost:9292/articles/#{article[:id]}"
    response.headers['Location'] = url
    status 201

    if sinatra_flash_error(article).length.positive?
      json_response(data: article)
      json_response(data: sinatra_flash_error(article))
    end
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method: Update the article in the DB according to :id
  put '/articles/:id/edit/?' do
    article = Article.find(article_id)
    article.update(data_json)
    status article ? 204 : 201

    if sinatra_flash_error(article).length.positive?
      json_response(data: article)
      json_response(data: sinatra_flash_error(article))
    end
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method: Delete the article in the DB according to :id
  delete '/articles/:id/destroy/?' do
    article = Article.find(article_id)
    article.destroy
    status 204
  rescue StandardError
    halt 422, 'Something wrong!'
  end
end
