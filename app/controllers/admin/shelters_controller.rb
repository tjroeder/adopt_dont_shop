class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.shelter_rev_alphabetical
    @shelters_pending = Shelter.shelter_filter_by_pending
  end
end