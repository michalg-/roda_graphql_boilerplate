# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.2'

group :development do
  gem 'byebug'
  gem 'rake'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'rubocop-shopify', require: false
  gem 'rubocop-thread_safety'
end

gem 'puma'
gem 'rack-protection'
gem 'roda'
gem 'roda-enhanced_logger'

# Graphql
gem 'graphql'

# Database Stack
gem 'pg'
gem 'sequel'
gem 'sequel_pg', require: false

group :development, :test do
  gem 'envyable'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
end
