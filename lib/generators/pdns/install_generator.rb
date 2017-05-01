module Pdns
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    desc 'Creates a Pdns initializer.'

    def copy_initializer
      template 'pdns.rb', 'config/initializers/pdns.rb'
      template 'database.yml', "config/database-#{Pdns.db_name}.yml"
    end
  end
end
