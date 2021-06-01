# frozen_string_literal: true
class Application
  hash_routes.on('graphiql') do |r|
    r.get(true) do
      helper = ::Graphiql.new(template_path: File.join(APP_ROOT, 'views', 'graphiql.erb'))
      helper.result
    end
  end
end
