class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show]

  def new
    @application = Application.new
  end

  def create
    app = Application.create(application_params)

    if app.save
      redirect_to application_path(app)
    else
      redirect_to new_application_path
      flash[:alert] = "Error: #{error_message(app.errors)}"
    end
  end

  def show
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code)
  end
end