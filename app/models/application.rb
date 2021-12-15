class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  after_initialize :set_defaults

  validates :name, :street_address, :city, :state, :zip_code, :description, :status, presence: true

  # Class Methods

  # Instance Methods
  def set_defaults
    self.description ||= 'Pet Application Request Description'
    self.status ||= 'In Progress'
  end

  def full_address
    "#{street_address} #{city}, #{state} #{zip_code}"
  end

  def pet_count
    pets.count
  end

  def all_pets_checked
    pet_applications.all? { |pet_app| pet_app.app_approval != 'undecided' }
  end

  def update_application_status
    
  end
end