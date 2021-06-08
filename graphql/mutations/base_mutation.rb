# frozen_string_literal: true
require_relative '../errors'

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Errors::Helper

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    field :errors, [Types::ErrorType], null: false, description: 'Returns errors'
    field :success, Boolean, null: false, description: 'Returns information if mutation was successful or not'

    def resolve(**kwargs)
      call(**kwargs)
      result
    end

    def success
      errors.empty?
    end

    def result
      @result ||= { success: success, errors: errors }
    end

    def add_result(hash)
      result.merge!(hash)
    end
  end
end
