# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

APP_ROOT = "#{__dir__}/.."

require 'rack/test'
require 'pry'

require_relative '../boot/load'
require_relative '../boot/db'

require 'simplecov'
require 'simplecov-lcov'

Dir.glob(File.join(APP_ROOT, 'spec', 'support', '**', '*.rb')).each { |file| require(file) }

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start do
  add_filter(%r{^/spec/})
  require 'undercover'
end

RSpec.configure do |config|
  config.include(Rack::Test::Methods, type: :request)
  config.include(RequestSupport, type: :request)

  config.around do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end

  config.include(
    Module.new do
      def app
        Application.freeze.app
      end
    end
  )

  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand(config.seed)
end
