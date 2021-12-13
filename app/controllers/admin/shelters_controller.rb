class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.shelter_rev_alphabetical
  end
end