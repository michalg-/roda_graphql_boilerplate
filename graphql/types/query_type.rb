# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    field :test, String, null: false
    def test
      'ok'
    end
  end
end
