module PDNS
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    namespace 'pdns:install'
    desc 'Creates a PDNS initializer.'

    def copy_initializer
      template 'pdns.rb', 'config/initializers/pdns.rb'
      template 'database.yml', "config/database-#{PDNS.db_name}.yml"
    end
  end
end
