# frozen_string_literal: true
require 'graphql/schema_comparator'

module SchemaUtils
  class Dump
    def self.call
      path = __dir__ + 'graphql'
      Dir[path + '**/*.rb'].each do |file|
        Kernel.require(file)
      end

      file = File.join('.', 'graphql', 'schema.idl')
      dir = File.dirname(file)
      FileUtils.mkdir_p(dir)
      new_schema = Schema.to_definition
      File.write(file, new_schema)
      new_schema
    end
  end

  class GenerateChangelog
    attr_reader :result

    def initialize(old_schema, new_schema)
      @result = GraphQL::SchemaComparator.compare(old_schema, new_schema)
    end

    def call
      return if result.identical?

      versions = %x(git tag -l v*.*.*).lines.map do |line_version|
        line_version[/v(.*)/, 1].split('.')
      end
      versions = versions.sort_by { |major, minor, patch| [major.to_i, minor.to_i, patch.to_i] }
      version = versions.last
      if result.changes.any?(&:breaking?)
        version[0] = version[0].to_i + 1
        version[1] = 0
      else
        version[1] = version[1].to_i + 1
      end
      version[2] = 0

      changelog = %x(git show origin/master:CHANGELOG_GRAPHQL.md).presence ||
        "# GraphQL Schema Changelog\n"
      changelog_lines = changelog.lines

      changes = []
      changes << changelog_lines.shift
      changes << "\n"
      changes << "## v#{version.join(".")} (#{Date.today})\n"
      changes += result.changes.map do |change|
        next("- 🛑  #{change.message}\n") if change.breaking?
        next("- ⚠️  #{change.message}\n") if change.dangerous?
        "- ✅  #{change.message}\n"
      end
      changes << "\n"
      changes << "---\n"
      File.write('CHANGELOG_GRAPHQL.md', (changes + changelog_lines).join)
    end
  end
end

namespace :graphql do
  namespace :schema do
    desc 'Dumps GraphQL schema in IDL'
    task :dump do
      new_schema = SchemaUtils::Dump.call
      old_schema = %x(git show origin/master:graphql/schema.idl)
      SchemaUtils::GenerateChangelog.new(old_schema, new_schema).call
    end
  end
end
