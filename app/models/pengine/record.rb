module Pengine
  class Record < ApplicationRecord
    self.inheritance_column = :_type_disabled
    belongs_to :domain

    validates :domain_id, presence: true
    validates :name, presence: true,
      format: { with: Pengine.domain_format },
      uniqueness: { scope: [:type, :content] }
    validates :type, presence: true, inclusion: {
      in: %w(SOA NS A CNAME MX TXT SRV PTR AAAA LOC SPF SSHFP)
    }
    validates :content, presence: true
    validates :ttl, numericality: true, presence: true
    validates :prio, numericality: { if: :mx? }, presence: { if: :mx? }

    before_update :set_change_date

    def mx?
      self.type == 'MX'
    end

    def update_serial
      soa = Record.where(domain_id: domain_id, type: "SOA").first
      unless soa.nil?
        list = soa.content.split(" ")
        serial = list[2]
        list[2] = serial.to_i + 1
        soa.update_column(:content, list.join(" "))
      end
    end

    private
    def set_change_date
      self.change_date = Time.now.to_i
    end
  end
end
