require_dependency 'pdns/application_controller'

module PDNS
  class DomainsController < ApplicationController
    def index
      set_domains

      render json: @domains, status: :ok
    end

    def show
      set_domain

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
      set_domain

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
      (params[:domain] || params).permit %i(name type)
    end

    def set_domains
      @domains = Domain.where(domain_params_for_index)
    end

    def domain_params_for_index
      (params[:domain] || params).permit %i(account)
    end
  end
end
