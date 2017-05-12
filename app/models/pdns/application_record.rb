module PDNS
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    establish_connection PDNS.db_conf[Rails.env.to_s]

    def as_json(options = nil)
      resource = self.class.name.split('::').last
      method = :"#{resource.downcase}_as_json"

      if PDNS.respond_to?(method) && PDNS.send(method).present?
        PDNS.send(method).call(attributes, options)
      else
        super
      end
    end
  end
end
