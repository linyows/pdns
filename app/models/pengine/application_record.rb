module Pengine
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    establish_connection Pengine.db_conf[Rails.env.to_s]
  end
end
