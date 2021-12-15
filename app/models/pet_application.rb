class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  enum app_approval: ['Undecided', 'Approved', 'Denied']
  after_initialize :set_defaults

  # Class Methods

  def self.find_by_application_and_pet(app_id, pet_id)
    find_by(application_id: app_id, pet_id: pet_id)
  end

  # Instance Methods
  
  def set_defaults
    self.app_approval ||= 'Undecided'
  end
end