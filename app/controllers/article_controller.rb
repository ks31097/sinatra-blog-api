# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../helpers/articles_helper'
require_relative '../models/article'

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
    if articles.to_s.length > 0 then
      json_response(data: articles)
    else
      json_response(data: 'No articles have been created yet!')
    end
  end

  # @method: Add a new article to the DB
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{}'
  # $curl -X POST 127.0.0.1:9292/articles_json/create -d '{"id":8,"title":"Article","content":"This is new article","autor":"Autor"}'
  post '/articles_json/create/?' do
    begin
      article = Article.create( self.data_json(created: true) )

      if sinatra_flash_error(article).length > 0 then
        json_response_db(data: article, message: sinatra_flash_error(article))
      else
        json_response_db(data: article, message: 'Current article')
      end
    rescue => e
      json_response(code: 422, data: { error: e.message })
    end
  end

  # @method: Display the article in json
  get '/articles_json/:id/?' do
    begin
      json_response(data: find_article)
    rescue => e
      json_response(code: 422, data: { error: e.message })
    end
  end

  # @method: Update the article in the DB according to :id
  # curl -X PUT 127.0.0.1:9292/articles_json/1/edit -d '{}'
  put '/articles_json/:id/edit/?' do
    begin
      article = Article.find(self.article_id)
      article.update(self.data_json)

      if sinatra_flash_error(article).length > 0 then
        json_response_db(data: article, message: sinatra_flash_error(article))
      else
        json_response_db(data: article, message: 'Current article')
      end
    rescue => e
      json_response(code: 422, data: { error: e.message })
    end
  end

  # @method: Delete the article in the DB according to :id
  # curl -X DELETE 127.0.0.1:9292/articles_json/15/destroy
  delete '/articles_json/:id/destroy/?' do
    begin
      article = Article.find(self.article_id)
      article.destroy
      json_response(data: { message: "Article deleted successfully!" })
    rescue => e
      json_response(code: 422, data: { error: e.message })
    end
  end
end
