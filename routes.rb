# frozen_string_literal: true

class Application
  route do |r|
    r.on('graphql') do
      r.post do
        result = Schema.execute(
          request.params['query'],
          variables: request.params['variables']
        )

        result.to_json
      end
    end
  end
end
