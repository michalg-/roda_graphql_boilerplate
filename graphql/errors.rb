# frozen_string_literal: true

class Errors < Array
  module Helper
    def errors
      @errors ||= Errors.new
    end
  end

  def add(*args)
    client_errors = args.compact.each_with_object([]) do |error, obj|
      case error
      when Errors
        obj.concat(error)
      when Array
        add(*error)
      else
        obj << ErrorMapper.build(error)
      end
    end
    concat(client_errors)
  end
  alias_method :<<, :add

  def to_h
    map(&:to_h)
  end

  def inspect
    "Error#{super}"
  end
end
