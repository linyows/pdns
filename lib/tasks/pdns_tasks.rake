require 'pdns'
include ActiveRecord::Tasks

namespace :pdns do
  task :prepare do
    DatabaseTasks.database_configuration = PDNS.db_conf
    DatabaseTasks.db_dir = PDNS.db_dir_path
    ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
    DatabaseTasks.current_config = DatabaseTasks.database_configuration[Rails.env]
  end

  desc 'Create database for PDNS'
  task create: %i(prepare) do
    DatabaseTasks.create_current
  end

  desc 'Drop database for PDNS'
  task drop: %i(prepare) do
    DatabaseTasks.drop_current
  end

  desc 'Load schema for PDNS'
  task migrate: %i(prepare) do
    DatabaseTasks.load_schema_current(:ruby)
  end

  desc 'Setup database for PDNS'
  task setup: %i(prepare create migrate)
end
