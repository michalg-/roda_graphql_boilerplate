# frozen_string_literal: true

$LOAD_PATH << __dir__
APP_ROOT = __dir__

require 'bundler'
require 'logger'
require 'byebug'

Bundler.require

require './lib/env'
environment_path = File.join(APP_ROOT, 'config', 'environments', "#{Env.name}.rb")
require environment_path if File.exist?(environment_path)

require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(
  subclasses: %w'Roda Sequel::Model',
  reload: Env.development?,
  logger: Logger.new($stdout)
) { Application }

unreloader_require = -> (file) { Unreloader.require(file) }

Dir.glob(File.join('api', '**', '*.rb')).sort.each(&unreloader_require)
Dir.glob(File.join('boot', '**', '*.rb')).sort.each(&unreloader_require)

Unreloader.require('application.rb') { 'Application' }
Unreloader.require('./routes.rb')
run(Env.development? ? Unreloader : Application.freeze.app)
