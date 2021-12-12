require 'rails_helper'

RSpec.describe '/applications/new.html.erb' do
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
      before(:each) { visit new_application_path }
      describe 'view elements' do
        it 'renders the new form' do
          expect(page).to have_content('New Application')
          expect(find('form')).to have_field('Name:', type: 'text')
          expect(find('form')).to have_field('Street Address:', type: 'text')
          expect(find('form')).to have_field('City:', type: 'text')
          expect(find('form')).to have_field('State:', type: 'text')
          expect(find('form')).to have_field('Zip Code:', type: 'text')
          expect(find('form')).to have_button('Create Application')
        end
      end

      describe 'creates a new application' do
        context 'given valid data' do
          it 'creates the new application and redirects to the show page' do
            new_app = {name: 'John', street: '555 Not Street', city: 'Little Apple', state: 'CA', zip: '22222'}
            fill_in 'Name:', with: new_app[:name]
            fill_in 'Street Address:', with: new_app[:street]
            fill_in 'City:', with: new_app[:city]
            fill_in 'State:', with: new_app[:state]
            fill_in 'Zip Code:', with: new_app[:zip]
            click_button 'Create Application'

            expected = Application.last
            expect(page).to have_current_path(application_path(expected.id))
            expect(page).to have_content(expected.name)
            expect(page).to have_content(expected.full_address)
            expect(page).to have_content('Application Status: In Progress')
            expect(page).to have_content('Pet Application Request Description')
          end
        end

        context 'given invalid data' do
          it 'redirects the user back to the new application page' do
            new_app = {name: 'John', street: '555 Not Street', city: 'Little Apple', state: 'CA', zip: '22222'}
            fill_in 'Name:', with: new_app[:name]
            fill_in 'Street Address:', with: new_app[:street]
            fill_in 'City:', with: new_app[:city]
            click_button 'Create Application'

            expect(page).to have_current_path(new_application_path)
            within("#flash-alert") do
              expect(page).to have_content("Error: State can't be blank, Zip code can't be blank")
            end
          end
        end
      end
    end
  end
end