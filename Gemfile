# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.2'

gem 'puma'
gem 'rack-protection'
gem 'rack-cors'
gem 'rack-unreloader'
gem 'roda'
gem 'roda-enhanced_logger'

# Graphql
gem 'graphql'

# Database Stack
gem 'pg'
gem 'sequel'
gem 'sequel_pg', require: false

gem 'zeitwerk'
gem 'listen'

gem 'hanami-utils'

group :development, :test do
  gem 'rake'
  gem 'envyable'
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'rubocop-shopify', require: false
  gem 'rubocop-thread_safety'
  gem 'rubocop-graphql', require: false
  gem 'graphql-schema_comparator'
  gem 'undercover'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov'
  gem 'simplecov-lcov'
end
