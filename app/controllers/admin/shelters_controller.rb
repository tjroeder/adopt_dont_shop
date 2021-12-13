class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelters.shelter_rev_alphabetical
  end
end