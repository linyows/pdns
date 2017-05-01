module Pdns
  class Domain < ApplicationRecord
    self.table_name = :domains
    self.inheritance_column = :_type_disabled
    has_many :records, dependent: :destroy

    validates :name, presence: true, uniqueness: true,
      format: { with: Pdns.domain_format }
    validates :type, presence: true, inclusion: {
      in: %w(NATIVE MASTER SLAVE SUPERSLAVE)
    }
  end
end
