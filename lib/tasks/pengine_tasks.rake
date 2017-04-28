require 'pengine'
include ActiveRecord::Tasks

namespace :pengine do
  task :prepare do
    DatabaseTasks.database_configuration = Pengine.db_conf
    DatabaseTasks.db_dir = Pengine.db_dir_path
    ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
    DatabaseTasks.current_config = DatabaseTasks.database_configuration[Rails.env]
  end

  desc 'Create database for Pengine'
  task create: %i(prepare) do
    DatabaseTasks.create_current
  end

  desc 'Drop database for Pengine'
  task drop: %i(prepare) do
    DatabaseTasks.drop_current
  end

  desc 'Setup database for Pengine'
  task setup: %i(prepare) do
    DatabaseTasks.load_schema_current(:ruby)
  end
end
