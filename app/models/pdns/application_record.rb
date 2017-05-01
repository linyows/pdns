module Pdns
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    establish_connection Pdns.db_conf[Rails.env.to_s]
  end
end
