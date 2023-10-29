[![Publish-App](https://github.com/ks31097/sinatra-blog-api/actions/workflows/main.yml/badge.svg)](https://github.com/ks31097/sinatra-blog-api/actions/workflows/main.yml)
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/ks31097/sinatra-blog-api/blob/main/LICENSE)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby](https://badgen.net/badge/icon/ruby?icon=ruby&label)](https://https://ruby-lang.org/)

# Sinatra-Blog
Sinatra-Blog is a basic API built with ruby's Sinatra DSL. 

## Built with
This application has been built with the following tools:
- **Ruby `v3.2.1`**
- **Sinatra `v3.0`**
- **SQlite3 `v1.6`**
- **ActiveRecord `v7.0`**
- **Rake `13.0`**
- **Puma `v6.2`**

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

## Client URL
1. Display a small welcome message with the current time
    ```
    $curl http://localhost:9292/hello
    ```
2. Display all articles
    ```
    $curl -i http://localhost:9292/articles \
     -H "Accept: application/xml;q=0.5, application/json"
    ```
3. Add a new article to the DB
    ```
    $curl -X POST 127.0.0.1:9292/articles/create -d '{}'

    $curl -X POST 127.0.0.1:9292/articles/create -d \
    '{"id":8,"title":"Article","content":"This is new article","autor":"Autor"}'
    ```
    ```
    $curl -X POST -v http://localhost:9292/articles/  \
    -H "Content-Type: application/json" \
    -d '{"title":"The first article", "content":"Article content", "user_id":1}'
    ```
4. curl -X PUT 127.0.0.1:9292/articles/1/edit -d '{}'
5. curl -X DELETE 127.0.0.1:9292/articles/15/destroy
  # $curl -X POST 127.0.0.1:9292/auth/register -d '{}'
  # @method: Create a new user

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

### ROUTES
1. `/hello` - Display a small welcome message with the current time.
2. `/articles_json` - Display all articles.

## LICENSE
This repository is distributed under the MIT License.

## Author
This repository is maintained by:
- [Kostiantyn Siharov](https://github.com/ks31097) 
