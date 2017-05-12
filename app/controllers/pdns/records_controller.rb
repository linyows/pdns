require_dependency 'pdns/application_controller'

module PDNS
  class RecordsController < ApplicationController
    def show
      set_domain
      set_record

      render json: @record, status: :ok
    end

    def create
      set_domain
      delete_records

      @record = @domain.records.create(record_params)

      if @record.save
        update_serial
        render json: @record, status: :created
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end

    def update
      set_domain
      set_record

      if @record.update(record_params)
        update_serial
        render json: @record, status: :ok
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end

    def destroy
      set_domain
      set_record

      @record.destroy
      update_serial
      head :no_content
    end

    def force_update_records
      set_domain

      type = params[:type] || 'A'
      @domain.records.where(type: type).update_all(record_params)
      render json: @domain.records.where(type: type), status: :ok
    end

    private

    def set_domain
      @domain = Domain.find_by(name: params[:domain_id])
      raise ActiveRecord::RecordNotFound.new(
        "#{params[:domain_id]} not found"
      ) if @domain.nil?
    end

    def set_record
      permitted = params.permit %i(id type content ttl prio auth)
      permitted[:name] = permitted.delete :id

      record = @domain.records.where(permitted)
      raise ActiveRecord::RecordNotFound.new(
        "record not found"
      ) if record.empty?

      raise ActiveRecord::ActiveRecordError.new(
        "record not unique"
      ) unless record.one?
      @record = record.first
    end

    def record_params
      (params[:record] || params).permit %i(name type content ttl prio auth)
    end

    def delete_records
      params['before_delete_conditions'].each do |condition|
        condition.each { |k, v| @domain.records.where(k => v).destroy_all }
      end if params['before_delete_conditions'].present?
    end

    def update_serial
      @record.update_serial if params[:skip_update_serial].nil?
    end
  end
end
