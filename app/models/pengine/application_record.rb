module Pengine
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    f = Rails.root.join('config',
      "database-#{Pengine.database_config_file_suffix}.yml")
    @_conf ||= ::YAML::load(ERB.new(IO.read(f.to_s)).result)[Rails.env.to_s]

    establish_connection @_conf
  end
end
