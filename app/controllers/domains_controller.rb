class DomainsController < ApplicationController
  before_action :set_domain, only: [:show]

  def show
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(domain_params)
    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render action: 'show', status: :created, location: @domain }
      else
        format.html { render action: 'new' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_domain
      @domain = Domain.find(params[:id])
    end

    def domain_params
      params.require(:domain).permit(:name)
    end
end