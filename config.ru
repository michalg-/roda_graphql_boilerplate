# frozen_string_literal: true

require './boot/load'

run(Env.development? ? Unreloader : Application.freeze.app)
