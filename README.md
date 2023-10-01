[![Publish-App](https://github.com/ks31097/sinatra-blog-api/actions/workflows/main.yml/badge.svg)](https://github.com/ks31097/sinatra-blog-api/actions/workflows/main.yml)
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/ks31097/sinatra-blog-api/blob/main/LICENSE)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby](https://badgen.net/badge/icon/ruby?icon=ruby&label)](https://https://ruby-lang.org/)

# Sinatra-Blog
Sinatra-Blog is a basic API built with ruby's Sinatra DSL. 
The application has been built with the MVC design pattern.

## Built With
This application has been built with the following tools:
- **Ruby `v3.2.1`**
- **SQlite3**
- **ActiveRecord**
- **Rake**
- **Puma**
- **Sinatra**

## Setup
You can setup this repository by following this manual

1. Clone the repository
    ```{shell}
    git clone https://github.com/ks31097/sinatra-blog-api.git
    ```
2. Ensure the ruby gems are setup in your machine
    ```
    bundle install
    ```
3. Perform any pending database migrations
    ```
    rake db:migrate
    ```
4. Run the application
    ```
    bundle exec rackup
    ```
5. Open the application from your browser
    ```
    http://localhost:9292/hello
    ```

## Client URL
1. Display a small welcome message with the current time
    ```
    $curl http://localhost:9292/hello
    ```
2. Display all articles
    ```
    $curl 127.0.0.1:9292/articles_json
    ```

## Application
This application is a simple web API that allows users to:
- Register a new account.
- Log in to existing account.
- Create the article.
- Update the article.
- View all articles.
- Delete the article.

### MODELS
Database schema definitions.

#### USER
| COLUMN          | DATA TYPE | DESCRIPTION                           | 
|-----------------|-----------|---------------------------------------|
| id              | Integer   | Unique identifier.                    |
| full_name       | String    | User full name.                       |
| email           | String    | User email.                           |
| password_digest | String    | User password hashed with `BCrypt`.   |
| created_at      | Date      | The date the user was created.        |
| updated_at      | Date      | The date the user was updated.        |

### ROUiTES
1. `/hello` - Display a small welcome message with the current time.
2. `/articles_json` - Display all articles.

## LICENSE
This repository is distributed under the MIT License.

## Author
This repository is maintained by:
- [Kostiantyn Siharov](https://github.com/ks31097) 
