# frozen_string_literal: true
module Env
  extend self

  def name
    ENV['RACK_ENV'] || 'development'
  end
end
