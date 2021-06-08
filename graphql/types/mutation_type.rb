# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    description('Home of all mutations')

    field :test, mutation: Mutations::Test, description: 'Returns test information'
  end
end
