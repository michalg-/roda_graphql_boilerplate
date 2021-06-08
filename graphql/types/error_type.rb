# frozen_string_literal: true
module Types
  class ErrorType < BaseObject
    description 'Error response'

    field :code, String, null: true, description: 'Returns errors code'
    field :field, String, null: true, description: 'Returns field'
    field :message, String, null: false, description: 'Returns message'
  end
end
