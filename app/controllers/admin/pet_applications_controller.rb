class Admin::PetApplicationsController < ApplicationController
  before_action :set_pet_application, only: [:update]

  def update
    if pet_app_params[:commit] == 'approve'
      @pet_application.approved!
    else
      @pet_application.denied!
    end
    
    @pet_application.application.update_application_status!
    redirect_to admin_application_path(@pet_application.application)
  end

  private

  def pet_app_params
    params.permit(:commit, :id)
  end

  def set_pet_application
    @pet_application = PetApplication.find(pet_app_params[:id])
  end
end