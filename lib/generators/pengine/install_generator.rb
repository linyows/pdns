module Pengine
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    desc 'Creates a Pengine initializer.'

    def copy_initializer
      template 'pengine.rb', 'config/initializers/pengine.rb'
      template 'database.yml', "config/database-#{Pengine.db_name}.yml"
    end
  end
end
