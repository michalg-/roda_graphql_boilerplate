# frozen_string_literal: true

require 'erb'

class Graphiql
  include ERB::Util

  def result
    template.result(binding)
  end

  private

  attr_reader :template

  def initialize(template_path:)
    @template = ERB.new(File.read(template_path))
  end
end
