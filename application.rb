# frozen_string_literal: true

# require './api/schema'

class Application < Roda
  use(Rack::Session::Cookie, secret: 'i-am-the-secret')
  use(Rack::Protection)
  use(Rack::Protection::RemoteReferrer)

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

  require './routes'
end
