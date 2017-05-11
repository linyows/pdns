require_dependency 'pdns/application_record'

module PDNS
  class Domain < ApplicationRecord
    self.table_name = :domains
    self.inheritance_column = :_type_disabled
    has_many :records, dependent: :destroy

    validates :name, presence: true, uniqueness: true,
      format: { with: PDNS.domain_format }
    validates :type, presence: true, inclusion: {
      in: %w(NATIVE MASTER SLAVE SUPERSLAVE)
    }
  end
end
