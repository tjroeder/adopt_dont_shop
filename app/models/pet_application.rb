class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  enum app_approval: ['undecided', 'approved', 'denied']
  after_initialize :set_defaults

  validates :pet, :application, :app_approval, presence: true

  # Class Methods

  def self.find_by_application_and_pet(app_id, pet_id)
    find_by(application_id: app_id, pet_id: pet_id)
  end

  # Instance Methods
  
  def set_defaults
    self.app_approval ||= 'undecided'
  end
end