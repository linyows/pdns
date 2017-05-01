module PDNS
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    establish_connection PDNS.db_conf[Rails.env.to_s]
  end
end
