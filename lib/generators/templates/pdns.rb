PDNS.setup do |c|
  # Defaults:
  # c.domain_format               = /\A[^-][a-z0-9\-\._]*[^-]\.[a-z0-9-]{2,}\Z/
  # c.domain_format_for_routes    = /[a-z0-9\-\._]*\.[a-z0-9-]{2,}/
  # c.db_name                     = :pdns
  # c.db_conf_path                = "config/database-#{self.db_name}.yml"
  # c.db_dir_path                 = File.expand_path('../../db', __FILE__)
  # c.domain_as_json              = nil
  # c.record_as_json              = nil

  # Examples:
  # c.domain_as_json              = ->(attrs, options) { attrs }
  # c.record_as_json              = ->(attrs, options) { attrs }
end
