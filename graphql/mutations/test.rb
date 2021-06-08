# frozen_string_literal: true
module Mutations
  class Test < BaseMutation
    description('Test mutation')

    argument :test, String, required: true, description: 'Consumes test information'

    field :test_response, String, null: true, description: 'Returns test information'

    def call(test:)
      if test == 'positive'
        add_result(test_response: 'positive')
      else
        errors.add('Test is negative')
      end
    end
  end
end
