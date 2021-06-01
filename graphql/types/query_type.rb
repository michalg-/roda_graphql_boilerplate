# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    description('Query')

    field :test, String, null: false, description: 'Test'
    def test
      'ok'
    end
  end
end
