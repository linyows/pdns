require 'pdns'
include ActiveRecord::Tasks

namespace :pdns do
  task :prepare do
    DatabaseTasks.database_configuration = Pdns.db_conf
    DatabaseTasks.db_dir = Pdns.db_dir_path
    ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
    DatabaseTasks.current_config = DatabaseTasks.database_configuration[Rails.env]
  end

  desc 'Create database for Pdns'
  task create: %i(prepare) do
    DatabaseTasks.create_current
  end

  desc 'Drop database for Pdns'
  task drop: %i(prepare) do
    DatabaseTasks.drop_current
  end

  desc 'Setup database for Pdns'
  task setup: %i(prepare) do
    DatabaseTasks.load_schema_current(:ruby)
  end
end
