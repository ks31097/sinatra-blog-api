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

    begin
      article = Article.create(data_json(created: true))
    rescue JSON::ParserError => e
      halt 400, send_data(json: -> { { message: e.to_s } },
                          xml: -> { { message: e.to_s } })
    end

    json_response(article, sinatra_flash_error(article)) if sinatra_flash_error(article).length.positive?

    url = "http://localhost:9292/articles/#{article[:id]}"
    response.headers['Location'] = url
    status 201
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
    begin
      article = Article.find(article_id)
    rescue StandardError
      halt 204
    end

    json_response(article, sinatra_flash_error(article)) if sinatra_flash_error(article).length.positive?
    article.update(data_json)
    status 201
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
