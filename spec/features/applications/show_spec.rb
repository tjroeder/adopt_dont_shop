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
      context 'status is in progress' do
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

          it 'displays pet search field and button when in progress' do
            visit new_application_path
            
            new_app = {name: 'John', street: '555 Not Street', city: 'Little Apple', state: 'CA', zip: '22222'}
            fill_in 'Name:', with: new_app[:name]
            fill_in 'Street Address:', with: new_app[:street]
            fill_in 'City:', with: new_app[:city]
            fill_in 'State:', with: new_app[:state]
            fill_in 'Zip Code:', with: new_app[:zip]
            click_button 'Create Application'

            expect(page).to have_current_path(application_path(Application.last))
            expect(page).to have_field(:search)
            expect(page).to have_button('Search')
          end

          it 'displays app desciption text field when greater than one pet added' do
            pet_5 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)

            visit application_path(application_1)
            expect(page).to have_no_field(:description)
            expect(page).to have_no_field(:submit)

            fill_in :search, with: "Ba"
            click_on("Search")
            click_on('Adopt this Pet', { class: "#adopt-#{pet_5.id}" })

            expect(page).to have_field('application_description')
          end
        end

        describe 'when interacts with page elements' do
          it 'redirects the user to the individual pet' do
            apply_app_1
            visit application_path(application_1)
            click_link "#{pet_1.name}"
    
            expect(page).to have_current_path(pet_path(pet_1))
          end

          it 'searchs for pets and displays them' do
            pet_5 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)

            visit application_path(application_1)
            fill_in :search, with: "Ba"
            click_on("Search")
            
            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_5.name)
            expect(page).to_not have_content(pet_2.name)
            expect(page).to_not have_content(pet_3.name)
            expect(page).to_not have_content(pet_4.name)
          end
          
          it 'searchs for pets case insensitive and partial matches' do
            visit application_path(application_1)
            fill_in :search, with: "O"
            click_on("Search")
            
            expect(page).to have_no_content(pet_1.name)
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_3.name)
            expect(page).to have_content(pet_4.name)
          end

          it 'adds the selected pet wishlist and displays them' do
            pet_5 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)

            visit application_path(application_1)

            fill_in :search, with: "Ba"
            click_on("Search")
            click_on('Adopt this Pet', { class: "#adopt-#{pet_5.id}" })

            within("#pet-#{pet_5.id}") do
              expect(page).to have_content(pet_5.name)
            end
          end

          it 'updates the description of the application and returns to the show page' do
            apply_app_1
            visit application_path(application_1)
            
            fill_in :application_description, with: "This is a new description"
            click_button 'Submit'
            
            expect(page).to have_current_path(application_path(application_1))
            expect(page).to have_content("This is a new description")
          end
          
          it 'updates the status to pending after submitting' do
            apply_app_1
            visit application_path(application_1)
            
            fill_in :application_description, with: "This is a new description"
            click_button 'Submit'
            
            expect(page).to have_content("Pending")
          end

          it 'shows all the pets the applicant wants to adopt after submit' do
            apply_app_1
            visit application_path(application_1)
            
            fill_in :application_description, with: "This is a new description"
            click_button 'Submit'
            
            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_3.name)
          end
          
          it 'does not show search pets after submit' do
            apply_app_1
            visit application_path(application_1)
            
            fill_in :application_description, with: "This is a new description"
            click_button 'Submit'
            
            expect(page).to have_no_content('Add a Pet to this Application:')
            expect(page).to have_no_button('Search')
          end
        end
      end
    end
  end
end