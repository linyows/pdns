require_dependency 'pdns/application_controller'

module PDNS
  class RecordsController < ApplicationController
    def index
      set_domain
      set_records

      render json: @records, status: :ok
    end

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
      set_records

      raise ActiveRecord::RecordNotFound.new(
        "record not found"
      ) if @records.empty?

      raise ActiveRecord::ActiveRecordError.new(
        "record not unique"
      ) unless @records.one?

      @record = @records.first
    end

    def record_params
      (params[:record] || params).permit %i(name type content ttl prio auth)
    end

    def record_params_with_id_to_name
      record_params.merge(name: params[:id])
    end

    def delete_records
      params['before_delete_conditions'].each do |condition|
        condition.each { |k, v| @domain.records.where(k => v).destroy_all }
      end if params['before_delete_conditions'].present?
    end

    def update_serial
      @record.update_serial if params[:skip_update_serial].nil?
    end

    def set_records
      @records = @domain.records.where(record_params)
    end
  end
end
