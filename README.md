# GithubTags

Pull GithHub repositories and group by Tags

## Warning

Make sure that your IP are not rate-limited (https://developer.github.com/v3/#rate-limiting), otherwise you can't run the project properly

## Context

Github provides a feature to "star" a project, but its not possible to group them or add tags

### The project

The project is a umbrella app, containing three apps: core, api and ui
The UI runs on port 4000 and API runs on 4002

----

Dependencies:
  - Elixir >1.5.X (Used v1.6.1 for dev)
  - Erlang >19.X (Used v20.2 for dev)
  - Postgres 9.5
  
## Development Setup

  * `cd your/path/github_tags`

#### Get Dependencies

  * `mix ecto.get`

#### Compile

  * `mix ecto.compile`

#### Create a Database

 - Note: (Verify the configs inside `apps/core/*.exs`(dev,test..) if (postgres) username and password is the same as yours ok, if not you must change it)

  * `mix ecto.create`

#### Create tables

  * `mix ecto.migrate`

#### Compile code

  * `mix compile`

## Running Test's

#### Run test's

  * `mix test`                                                                                                 
  
# Githubtags.UI (User Interface)

To start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd apps/ui/assets && npm install`
  * Run Brunch build with `node_modules/brunch/bin/brunch build`
  * Start Phoenix endpoint with `mix phx.server` (can be executed in project root folder)

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## API playground

  * on root folder type `iex -S mix phx.server`
  
#### Creating an User and pupulate repos to DB

```Shell
$ curl -X PUT http://localhost:4002/api/create_user/mbenatti
{"status":200,"message":"User created"}
```

#### Get a repository by user

```Shell
$ curl -X GET http://localhost:4002/api/repositories/empty_or_invalid_user
{"status":200,"result":[]}

$ curl -X GET http://localhost:4002/api/repositories/fabianopaes
{"status":200,"result":[{"user":"fabianopaes","url":"https://github.com/akullpp/awesome-java","updated_at":"2018-03-26T03:08:57.142882","tags":["elixirr","elixir"],"name":"awesome-java","language":null,"inserted_at":"2018-03-26T03:08:19.653554","id":283,"description":"A curated list of awesome frameworks, libraries and software for the Java programming language."},...]}
```

#### Get a repository by tag

```Shell

$ curl -X GET http://localhost:4002/api/repositories/mbenatti/elixir
{"status":200,"result":[{"user":"mbenatti","url":"https://github.com/2trde/excrawl","updated_at":"2018-03-26T03:01:55.738564","tags":["tag2","elixir"],"name":"excrawl","language":"Elixir","inserted_at":"2018-03-26T03:01:13.962738","id":168,"description":"Elixir web crawler"}]}

```

#### Add tag

```Shell
$ curl -H "Content-Type: application/json" -X POST -d '{"user":"mbenatti","url":"https://github.com/h4cc/awesome-elixir","tag":"elixir-lang"}' http://localhost:4002/api/repositories/add_tag
{"status":200,"message":"Tag added"}
```

#### Remove tag

```Shell
$ curl -H "Content-Type: application/json" -X POST -d '{"user":"mbenatti","url":"https://github.com/h4cc/awesome-elixir","tag":"elixir-lang"}' http://localhost:4002/api/repositories/remove_tag
{"status":200,"message":"Tag removed"}

$ curl -H "Content-Type: application/json" -X POST -d '{"user":"mbenattii","url":"https://github.com/h4cc/awesome-elixirr","tag":"elixir-lang"}' http://localhost:4002/api/repositories/remove_tag
{"status":200,"message":"repository not found"}
```


