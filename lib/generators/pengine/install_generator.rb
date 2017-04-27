module Pengine
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    desc 'Creates a Pengine initializer.'

    def copy_initializer
      template 'pengine.rb', 'config/initializers/pengine.rb'
      template 'database-pdns.yml', 'config/database-pdns.yml'
    end
  end
end
