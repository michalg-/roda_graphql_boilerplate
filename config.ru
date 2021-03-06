# frozen_string_literal: true
APP_ROOT = __dir__

require './boot/load'

unless Env.development?
  Application.freeze
end

run(Application.app)
