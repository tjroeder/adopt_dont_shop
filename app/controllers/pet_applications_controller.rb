class PetApplicationsController < ApplicationController
  def create
    app = Application.find(pet_app_params[:app_id])
    pet = Pet.find(pet_app_params[:pet_id])
    PetApplication.create!(application: app, pet: pet)
    redirect_to application_path(app)
  end

  private

  def pet_app_params
    params.permit(:app_id, :pet_id)
  end
end