class DomainsController < ApplicationController
  def show
    @domain = Domain.find(params[:id])
  end
end
