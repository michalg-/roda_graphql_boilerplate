# frozen_string_literal: true
APP_ROOT = __dir__

require './boot/load'

run(Application.freeze.app)
