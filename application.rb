# frozen_string_literal: true

# require './api/schema'

class Application < Roda
  use(Rack::Session::Cookie, secret: ENV['COOKIE_SECRET'])
  use(Rack::Protection)
  use(Rack::Protection::RemoteReferrer)
  use(Rack::Cors, debug: Env.development?, logger: Logger.new($stdout)) do
    allow do
      origins ENV['FRONTEND_DOMAIN']
      resource '*', headers: :any, methods: %i[get post put delete options head]
    end
  end

  plugin(:environments)

  configure(:staging, :production) do
    plugin(:heartbeat)
  end

  configure(:development) do
    plugin(:enhanced_logger)
  end

  plugin(:json)
  plugin(:json_parser)

  plugin(:all_verbs)
end
