# frozen_string_literal: true
require 'bundler'
require 'logger'

Bundler.require

require './lib/env'

environment_path = File.join(APP_ROOT, 'config', 'environments', "#{Env.name}.rb")
require environment_path if File.exist?(environment_path)

require './application'
require_relative './db'
require_relative './sequel'

require 'zeitwerk'
require 'listen'

loader = Zeitwerk::Loader.new
loader.push_dir(File.join(APP_ROOT, 'graphql'))
loader.push_dir(File.join(APP_ROOT, 'lib'))
loader.push_dir(File.join(APP_ROOT, 'models'))
loader.push_dir(File.join(APP_ROOT, 'routes'))
loader.ignore(File.join(APP_ROOT, 'routes'))
loader.push_dir(File.join(APP_ROOT, 'spec')) if Env.test?
loader.enable_reloading
loader.setup

Listen.to(APP_ROOT) { loader.reload }.start
