# frozen_string_literal: true
require 'logger'
require 'yaml'

case Env.name
when 'development', 'test'
  DB = Sequel.connect(
    **YAML.load(File.read('./config/database.yml'))[Env.name],
    logger: Logger.new($stdout)
  )
end
