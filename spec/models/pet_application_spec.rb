require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe 'validations' do
    it { should validate_presence_of(:pet) }
    it { should validate_presence_of(:application) }
    it { should validate_presence_of(:app_approval) }
    it { should define_enum_for(:app_approval) }
    it do
      should define_enum_for(:app_approval).with_values(['undecided', 'approved', 'denied'])
    end
  end

  let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create!(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: true, rank: 6) }
  let!(:shelter_3) { Shelter.create!(name: 'Animal House', city: 'Fort Collins, CO', foster_program: false, rank: 9) }

  let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald') }
  let!(:pet_2) { shelter_3.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster') }
  let!(:pet_3) { shelter_3.pets.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven') }
  let!(:pet_4) { shelter_2.pets.create!(adoptable: false, age: 5, breed: 'dachshund', name: 'Woodrow') }

  let!(:application_1) { Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345') }
  let!(:application_2) { Application.create!(name: 'Sue', street_address: '321 Burrito Lane', city: 'Boulder', state: 'UT', zip_code: '54321') }
  let!(:application_3) { Application.create!(name: 'Case', street_address: '4231 Chili Lane', city: 'Denver', state: 'NY', zip_code: '33333') }

  let!(:pet_app_1) { PetApplication.create!(pet: pet_1, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: pet_2, application: application_1) }
  let!(:pet_app_3) { PetApplication.create!(pet: pet_3, application: application_1) }

  let(:apply_app_2) { 
    PetApplication.create!(pet: pet_2, application: application_2)
    PetApplication.create!(pet: pet_4, application: application_2)
  }

  describe 'class methods' do
    describe '::find_by_application_and_pet' do
      it 'returns the pet application given application and pet ids' do
        expectation = PetApplication.find_by_application_and_pet(application_1.id, pet_1.id) 

        expect(expectation).to eq(pet_app_1)
      end
    end
  end

  describe 'instance methods' do
    describe '#set_defaults' do
      it 'sets the default app_approval to undecided' do
        expectation = PetApplication.create!(pet: pet_4, application: application_1)

        expect(expectation.app_approval).to eq('undecided') 
      end
    end
  end
end