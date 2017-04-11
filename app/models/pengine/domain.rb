module Pengine
  class Domain < ApplicationRecord
    self.inheritance_column = :_type_disabled
    has_many :records, dependent: :destroy

    validates :name, presence: true, uniqueness: true,
      format: { with: DOMAIN_FORMAT }
    validates :type, presence: true, inclusion: {
      in: %w(NATIVE MASTER SLAVE SUPERSLAVE)
    }
  end
end
