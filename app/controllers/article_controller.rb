# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/articles_helper'
require_relative '../models/article'
require 'pry'
class ArticleController < ApplicationController
  configure do
    helpers ArticlesHelper
  end

  # @method: Display a small welcome message
  get '/hello' do
    "The server is up and running! The current time: #{server_time_run}"
  end

  # @method: Display all articles in json
  # $curl 127.0.0.1:9292/articles_json
  get '/articles_json/?' do
    articles = find_articles
    if articles.length.positive?
      json_response(data: articles)
    else
      json_response(data: 'No articles have been created yet!')
    end
  end

  # @method: Add a new article to the DB
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{}'
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d \
  # '{"id":8,"title":"Article","content":"This is new article","autor":"Autor"}'
  post '/articles_json/create/?' do
    article = Article.create(data_json(created: true))

    if sinatra_flash_error(article).length.positive?
      json_response_db(data: article, message: sinatra_flash_error(article))
    else
      json_response_db(data: article, message: 'Current article')
    end
  rescue StandardError => e
    json_response(code: 422, data: { error: e.message })
  end

  # @method: Display the article in json
  get '/articles_json/:id/?' do
    json_response(data: find_article)
  rescue StandardError => e
    json_response(code: 422, data: { error: e.message })
  end

  # @method: Update the article in the DB according to :id
  # curl -X PUT 127.0.0.1:9292/articles_json/1/edit -d '{}'
  put '/articles_json/:id/edit/?' do
    article = Article.find(article_id)
    article.update(data_json)

    if sinatra_flash_error(article).length.positive?
      json_response_db(data: article, message: sinatra_flash_error(article))
    else
      json_response_db(data: article, message: 'Current article')
    end
  rescue StandardError => e
    json_response(code: 422, data: { error: e.message })
  end

  # @method: Delete the article in the DB according to :id
  # curl -X DELETE 127.0.0.1:9292/articles_json/15/destroy
  delete '/articles_json/:id/destroy/?' do
    article = Article.find(article_id)
    article.destroy
    json_response(data: { message: 'Article deleted successfully!' })
  rescue StandardError => e
    json_response(code: 422, data: { error: e.message })
  end
end
