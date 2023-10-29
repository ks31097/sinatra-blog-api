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
    send_data(json: -> { response_message(find_articles) },
              xml: -> { { articles: response_message(find_articles) } })
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method: Display the article
  get '/articles/:id/?' do
    send_data(json: -> { response_message(find_article) },
              xml: -> { { articles: response_message(find_article) } })
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method: Receiving back information from the GET request by the client
  head '/articles/?' do
    send_data
  end

  # @method: Add a new article to the DB
  post '/articles/?' do
    halt 415 unless request.env['CONTENT_TYPE'] == 'application/json'

    article = Article.create(data_json(created: true))
    url = "http://localhost:9292/articles/#{article[:id]}"
    response.headers['Location'] = url
    status 201

    json_response(article, sinatra_flash_error(article)) if sinatra_flash_error(article).length.positive?
  rescue StandardError
    halt 422, 'Something wrong!'
  end

  # @method not allowed
  %i[put delete].each do |method|
    send(method, '/articles/?') do
      halt 405
    end
  end

  # @method: Update the article in the DB according to :id
  put '/articles/:id/edit/?' do
    article = Article.find(article_id)
    article.update(data_json)
    status article ? 204 : 201

    json_response(article, sinatra_flash_error(article)) if sinatra_flash_error(article).length.positive?
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
