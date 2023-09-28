# frozen_string_literal: true

require_relative 'config/environment'

use Rack::MethodOverride

use ArticleController
run UserController
