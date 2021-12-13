class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update]

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

  def update
    @application.update!(application_params)
    redirect_to application_path
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end