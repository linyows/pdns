require 'pdns/engine'
require 'pdns/inflect'

module PDNS
  mattr_accessor :domain_format
  self.domain_format = /\A[^-][a-z0-9\-\._]*[^-]\.[a-z0-9-]{2,}\Z/

  mattr_accessor :domain_format_for_routes
  self.domain_format_for_routes = /[a-z0-9\-\._]*\.[a-z0-9-]{2,}/

  mattr_accessor :db_name
  self.db_name = :pdns

  mattr_accessor :db_conf_path
  self.db_conf_path = "config/database-#{self.db_name}.yml"

  mattr_accessor :db_dir_path
  self.db_dir_path = File.expand_path('../../db', __FILE__)

  mattr_accessor :migrations_path
  self.migrations_path = File.expand_path('../../db/migrate', __FILE__)

  mattr_accessor :domain_as_json
  self.domain_as_json = nil

  mattr_accessor :record_as_json
  self.record_as_json = nil

  class << self
    def setup
      yield self
    end

    def db_conf
      @db_conf ||= ::YAML::load(ERB.new(IO.read(self.db_conf_path.to_s)).result)
    end
  end
end
