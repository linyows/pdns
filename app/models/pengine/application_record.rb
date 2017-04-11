module Pengine
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    DOMAIN_FORMAT = /\A[^-][a-z0-9\-\._]*[^-]\.[a-z0-9-]{2,}\Z/
  end
end
