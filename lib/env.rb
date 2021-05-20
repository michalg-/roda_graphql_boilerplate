# frozen_string_literal: true
module Env
  extend self

  def development?
    name == 'development'
  end

  def name
    ENV['RACK_ENV'] || 'development'
  end
end
