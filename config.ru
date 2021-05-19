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

Dir.glob(File.join('api', '**', '*.rb')).sort.each(&method(:require))
Dir.glob(File.join('boot', '**', '*.rb')).sort.each(&method(:require))

require './application'

run Application.freeze.app
