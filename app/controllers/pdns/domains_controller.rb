require_dependency 'pdns/application_controller'

module Pdns
  class DomainsController < ApplicationController
    before_action :set_domain, only: %i(show destroy)

    def show
      render json: @domain, status: :ok
    end

    def create
      @domain = Domain.new(domain_params)

      if @domain.save
        render json: @domain, status: :created
      else
        render json: @domain.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @domain.destroy
      head :no_content
    end

    private

    def set_domain
      @domain = Domain.find_by(name: params[:id])
      raise ActiveRecord::RecordNotFound.new(
        "#{params[:id]} not found"
      ) if @domain.nil?
    end

    def domain_params
      params[:domain].permit %i(name type)
    end
  end
end
