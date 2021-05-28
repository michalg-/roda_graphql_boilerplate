# frozen_string_literal: true

class Application
  hash_branch('graphql') do |r|
    r.post do
      context = {}
      result = Schema.execute(
        request.params['query'],
        variables: request.params['variables'],
        context: context,
        operation_name: request.params['operationName']
      )

      result.to_json
    rescue => e
      raise e unless Env.development?
      $stderr.print(e.message)
      $stderr.print(e.backtrace.join("\n"))
      response.status = 500
      { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }
    end
  end
end
