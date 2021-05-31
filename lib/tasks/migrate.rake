# frozen_string_literal: true

namespace :generate do
  desc 'Create new migration file'
  task :migration, [:name] do
    require 'sequel/core'
    require 'hanami/utils/string'
    Sequel.extension(:migration)
    name = ARGV[1] || raise('Missing name: rake generate:migration your_migration_name')

    version = Time.now.strftime('%Y%m%d%H%M%S%L')

    FileUtils.touch(File.join('db', 'migrations', "#{version}_#{Hanami::Utils::String.underscore(name)}.rb"))
    abort
  end
end

namespace :db do
  require 'sequel/core'
  Sequel.extension(:migration)

  desc 'Prints current schema version'
  task :version do
    version = DB.tables.include?(:schema_migrations) ? DB[:schema_migrations].first&.dig(:filename) : 0

    puts "Schema Version: #{version}"
  end

  desc 'Rollback step back or specified target'
  task :rollback, :target do |_t, args|
    target = if DB[:schema_migrations].count > 1
      DB[:schema_migrations].limit(2).order(Sequel.desc(:filename)).all.last.dig(:filename).split('_').first
    else
      0
    end

    args.with_defaults(target: target)

    Sequel::Migrator.run(DB, 'db/migrations', target: args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    version = args[:version].to_i if args[:version]
    Sequel::Migrator.run(DB, 'db/migrations', target: version)
  end

  desc 'Reset migrations'
  task :reset do
    Sequel::Migrator.run(DB, 'migrations', target: 0)
    Sequel::Migrator.run(DB, 'migrations')
    Rake::Task['db:version'].execute
  end
end
