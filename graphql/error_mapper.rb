# frozen_string_literal: true

class ErrorMapper
  attr_reader :message, :field, :code

  def self.build(error)
    case error
    when Hash
      new(field: error[:field], code: error[:code], message: message)
    when ErrorMapper
      error
    when String
      new(field: nil, message: error)
    else
      raise NotImplementedError, "No mapping for #{error.class.name}"
    end
  end
  private_class_method :new

  def initialize(message:, field: nil, code: nil)
    @field = field
    @code = code
    @message = message
  end

  def ==(other)
    return false unless other.is_a?(self.class)
    field == other.field && message == other.message && code == other.code
  end
end
