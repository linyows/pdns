require 'pengine/engine'

module Pengine
  mattr_accessor :domain_format
  self.domain_format = /\A[^-][a-z0-9\-\._]*[^-]\.[a-z0-9-]{2,}\Z/

  mattr_accessor :domain_format_for_routes
  self.domain_format_for_routes = /[a-z0-9\-\._]*\.[a-z0-9-]{2,}/

  mattr_accessor :database_config_file_suffix
  self.database_config_file_suffix = :pdns

  def self.setup
    yield self
  end
end
