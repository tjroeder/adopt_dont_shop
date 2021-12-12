class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show]

  def new
    @application = Application.new
  end

  def create
    application = Application.create!(application_params)
    redirect_to application_path(application)
  end

  def show
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code)
  end
end