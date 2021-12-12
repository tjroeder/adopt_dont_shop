require 'rails_helper'

RSpec.describe 'the pets index' do
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

  let(:apply_app_2) { 
    PetApplication.create!(pet: pet_2, application: application_2)
    PetApplication.create!(pet: pet_4, application: application_2)
  }

  describe 'as a user' do
    describe 'when visit the page' do
      before(:each) { visit pets_path }

      describe 'view elements' do
        it 'lists all the pets with their attributes' do
          visit pets_path
      
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_1.breed)
          expect(page).to have_content(pet_1.age)
          expect(page).to have_content(shelter_1.name)
      
          expect(page).to have_content(pet_2.name)
          expect(page).to have_content(pet_2.breed)
          expect(page).to have_content(pet_2.age)
          expect(page).to have_content(shelter_3.name)
        end
      
        it 'only lists adoptable pets' do
          expect(page).to_not have_content(pet_3.name)
          expect(page).to_not have_content(pet_4.name)
        end
      
        it 'displays a link to edit each pet' do
          expect(page).to have_link("Edit #{pet_1.name}", href: edit_pet_path(pet_1))
          expect(page).to have_link("Edit #{pet_2.name}", href: edit_pet_path(pet_2))
        end
        
        it 'displays a link to delete each pet' do
          expect(page).to have_link("Delete #{pet_1.name}", href: pet_path(pet_1))
          expect(page).to have_link("Delete #{pet_2.name}", href: pet_path(pet_2))
        end

        it 'has a text box to filter results by keyword' do
          expect(page).to have_button("Search")
        end

        it 'has a link to create a new application' do
          expect(page).to have_link('Start an Application', href: new_application_path)
        end
      end
      
      describe 'when click links' do
        it 'redirects the user to edit pet' do
          click_link("Edit #{pet_1.name}")
          
          expect(page).to have_current_path(edit_pet_path(pet_1))
        end
        
        it 'redirects the user to delete the pet' do
          click_link("Delete #{pet_1.name}")
          
          expect(page).to have_current_path(pets_path)
          expect(page).to_not have_content(pet_1.name)
        end

        it 'redirects the user to start a new application' do
          click_link 'Start an Application'
          
          expect(page).to have_current_path(new_application_path)
        end
      end
      
      describe 'when click buttons' do
        it 'lists partial matches as search results' do
          pet_5 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)
          
          visit pets_path
          
          fill_in :search, with: "Ba"
          click_on("Search")
          
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_5.name)
          expect(page).to_not have_content(pet_2.name)
          expect(page).to_not have_content(pet_3.name)
          expect(page).to_not have_content(pet_4.name)
        end
      end
    end
  end
end
