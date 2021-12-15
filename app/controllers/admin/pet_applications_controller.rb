class Admin::PetApplicationsController < ApplicationController
  before_action :set_pet_application, only: [:update]

  def update
    if pet_app_params[:commit] == 'approved'
      @pet_application.approved!
    else
      @pet_application.denied!
    end
    redirect_to admin_application_path(@pet_application)
  end

  private

  def pet_app_params
    params.permit(:commit, :id)
  end

  def set_pet_application
    @pet_application = PetApplication.find(pet_app_params[:id])
  end
end