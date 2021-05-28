# frozen_string_literal: true

def execute_schema(file_path, variables: {}, context: {})
  query = IO.read("./spec/graphql_queries/#{file_path}.graphql")

  Schema.execute(
    query,
    variables: variables,
    context: context
  )
end
