## Setup
1. copy example database connection configuration file `cp config/database.yml.example config/database.yml`
2. create development and test databases and fill in a configuration file `config/database.yml`
3. run migrations `rake db:migrate`
4. copy example ENV configuration file `cp config/env.yml.example config/env.yml`
5. fill in a ENV configuration file
6. run server `puma -C config/puma.rb`

## Developing
1. to jump into development console just type `bin/console`
2. you can use `binding.pry` anytime and anywhere in the app
3. graphiQL explorer is available under http://localhost:3000/graphiql
4. to create GraphQL API changelog just run `rake graphql:schema:dump`

## Testing
1. application has already preconfigured rspec, so do as usual `rspec spec`

## Migrations
1. generate migration file
`rake generate:migration i-am-the-migration-name`
2. fill in created migration _(db/migrations)_, for instance:
```ruby
Sequel.migration do
  change do
    run 'CREATE EXTENSION "uuid-ossp"'
    create_table(:artists) do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      String :name, null: false
      DateTime :created_at, null: false, default: Sequel.function(:now)
      DateTime :updated_at, null: false, default: Sequel.function(:now)
    end
  end
end
```
3. run migration
`rake db:migrate`
