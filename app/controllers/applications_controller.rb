class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show]

  def show
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end
end