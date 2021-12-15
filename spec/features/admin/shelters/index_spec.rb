require 'rails_helper'

RSpec.describe '/admin/shelters/index.html.erb', type: :feature do
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

  let(:apply_app_1) { 
    PetApplication.create!(pet: pet_1, application: application_1)
    PetApplication.create!(pet: pet_2, application: application_1)
    PetApplication.create!(pet: pet_3, application: application_1)
  }

  describe 'as an admin' do
    describe 'when visit the page' do
      describe 'view elements' do
        it 'displays the shelters in reverse alphabetical order' do
          visit admin_shelters_path
          
          expect(page).to have_current_path(admin_shelters_path)
          expect(shelter_2.name).to appear_before(shelter_1.name)
          expect(shelter_2.name).to appear_before(shelter_3.name)
          expect(shelter_1.name).to appear_before(shelter_3.name)
        end

        it 'has section to display shelters with pending applications' do
          apply_app_1
          application_1.update!(status: 'Pending')
          visit admin_shelters_path

          within("#shelters-pending") do
            expect(page).to have_content(shelter_1.name)
            expect(page).to have_content(shelter_3.name)
            expect(page).to have_no_content(shelter_2.name)
          end
        end
      end
    end
  end
end