require 'rails_helper'

RSpec.describe '/applications/show.html.erb', type: :feature do
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
      describe 'view elements' do
        it 'displays applicant name' do
          visit application_path(application_1)
          
          expect(page).to have_content(application_1.name)
        end

        it 'displays applicant full address' do
          visit application_path(application_1)
          
          expect(page).to have_content(application_1.full_address)
        end

        it 'displays application status' do
          visit application_path(application_1)
          
          expect(page).to have_content(application_1.status)
        end
        
        it 'displays pets wishing to adopt with links to pet' do
          apply_app_1
          visit application_path(application_1)

          within("#pet-#{pet_1.id}") do
            expect(page).to have_link(pet_1.name, href: pet_path(pet_1))
          end
          
          within("#pet-#{pet_2.id}") do
            expect(page).to have_link(pet_2.name, href: pet_path(pet_2))
          end
          within("#pet-#{pet_3.id}") do
            expect(page).to have_link(pet_3.name, href: pet_path(pet_3))
          end
        end

        it 'displays applicant adoption request description' do
          visit application_path(application_1)
          
          expect(page).to have_content(application_1.description)
        end
      end
    end

    describe 'when click links' do
      it 'redirects the user to the individual pet' do
        apply_app_1
        visit application_path(application_1)
        save_and_open_page
        click_link "#{pet_1.name}"


        expect(page).to have_current_path(pet_path(pet_1))
      end
    end
  end
end