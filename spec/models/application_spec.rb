require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
    it { should validate_presence_of :status }
  end

  let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create!(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: true, rank: 6) }
  let!(:shelter_3) { Shelter.create!(name: 'Animal House', city: 'Fort Collins, CO', foster_program: false, rank: 9) }
  
  let!(:application_1) { Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345') }
  let!(:application_2) { Application.create!(name: 'Sue', street_address: '321 Burrito Lane', city: 'Boulder', state: 'UT', zip_code: '54321') }
  let!(:application_3) { Application.create!(name: 'Case', street_address: '4231 Chili Lane', city: 'Denver', state: 'NY', zip_code: '33333') }

  let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald') }
  let!(:pet_2) { shelter_3.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster') }
  let!(:pet_3) { shelter_3.pets.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven') }
  let!(:pet_4) { shelter_2.pets.create!(adoptable: false, age: 5, breed: 'dachshund', name: 'Woodrow') }

  let!(:pet_app_1) { PetApplication.create!(pet: pet_1, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: pet_2, application: application_1) }
  let!(:pet_app_3) { PetApplication.create!(pet: pet_3, application: application_1) }

  describe 'class methods' do

  end

  describe 'instance methods' do
    describe '#set_defaults' do
      it 'should set the default description upon creation' do
        application_1 = Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345')

        expected = 'Pet Application Request Description'
        expect(application_1.description).to eq(expected)
      end

      it 'should set the default status upon creation' do
        application_1 = Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345')

        expected = 'In Progress'
        expect(application_1.status).to eq(expected)
      end
    end

    describe '#full_address' do
      it 'should return the full concatenated address' do
        expected = "#{application_1.street_address} #{application_1.city}, #{application_1.state} #{application_1.zip_code}"
        expect(application_1.full_address).to eq(expected)
      end
    end

    describe '#pet_count' do
      it 'should return the amount of pets for the application' do
        expect(application_1.pet_count).to eq(3)
      end
    end

    describe '#all_pets_checked' do
      it 'should return true if all pets are no longer undecided' do
        pet_app_1.approved!
        pet_app_2.approved!
        pet_app_3.denied!

        expect(application_1.all_pets_checked).to eq(true)
      end
      
      it 'should return false if not all pets are approved or denied' do
        pet_app_1.approved!
        pet_app_3.denied!
        
        expect(application_1.all_pets_checked).to eq(false)
      end
    end
  end
end