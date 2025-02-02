require 'rails_helper'

RSpec.describe '/admin/applications/show.html.erb', type: :feature do
  let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create!(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: true, rank: 6) }
  let!(:shelter_3) { Shelter.create!(name: 'Animal House', city: 'Fort Collins, CO', foster_program: false, rank: 9) }

  let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald') }
  let!(:pet_2) { shelter_3.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster') }
  let!(:pet_3) { shelter_3.pets.create!(adoptable: true, age: 2, breed: 'saint bernard', name: 'Beethoven') }
  let!(:pet_4) { shelter_2.pets.create!(adoptable: true, age: 5, breed: 'dachshund', name: 'Woodrow') }

  let!(:application_1) { Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345', status: 'Pending') }
  let!(:application_2) { Application.create!(name: 'Sue', street_address: '321 Burrito Lane', city: 'Boulder', state: 'UT', zip_code: '54321') }
  let!(:application_3) { Application.create!(name: 'Case', street_address: '4231 Chili Lane', city: 'Denver', state: 'NY', zip_code: '33333') }

  let!(:pet_app_1) { PetApplication.create!(pet: pet_1, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: pet_2, application: application_1) }
  let!(:pet_app_3) { PetApplication.create!(pet: pet_3, application: application_1) }

  let!(:pet_app_4) { PetApplication.create!(pet: pet_1, application: application_2) }
  let!(:pet_app_5) { PetApplication.create!(pet: pet_2, application: application_2) }
  let!(:pet_app_6) { PetApplication.create!(pet: pet_4, application: application_2) }

  describe 'as an admin' do
    describe 'when visit the page' do
      before(:each) { visit admin_application_path(application_1) }
      context 'application is pending' do
        describe 'view elements' do
          it 'shows pets on the application' do
            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_3.name)
            expect(page).to have_no_content(pet_4.name)
          end

          it 'shows application pending status for the application' do
            expect(page).to have_content("Application Status: Pending")
          end
          
          it 'has buttons to approve each pet' do
            within("##{pet_app_1.pet_id}") do
              expect(page).to have_button('approve')
            end
            
            within("##{pet_app_2.pet_id}") do
              expect(page).to have_button('approve')
            end
            
            within("##{pet_app_3.pet_id}") do
              expect(page).to have_button('approve')
            end
          end
          
          it 'has buttons to deny each pet' do
            within("##{pet_app_1.pet_id}") do
              expect(page).to have_button('deny')
            end
            
            within("##{pet_app_2.pet_id}") do
              expect(page).to have_button('deny')
            end
            
            within("##{pet_app_3.pet_id}") do
              expect(page).to have_button('deny')
            end
          end
        end
        
        describe 'when interacts with page elements' do
          it 'returns back to application show page after approving pet' do
            expect(page).to have_current_path(admin_application_path(application_1))
            
            within("##{pet_app_1.pet_id}") do
              click_button('approve')

              expect(page).to have_current_path(admin_application_path(application_1))
            end
          end
          
          it 'returns back to application show page after rejecting pet' do
            expect(page).to have_current_path(admin_application_path(application_1))
            
            within("##{pet_app_1.pet_id}") do
              click_button('deny')

              expect(page).to have_current_path(admin_application_path(application_1))
            end
          end
          
          it 'after pet is approved, their approval buttons are removed' do
            within("##{pet_app_1.pet_id}") do
              click_button('approve')
            end
            
            within("##{pet_app_1.pet_id}") do
              expect(page).to have_no_button('approve')
            end
            
            within("##{pet_app_2.pet_id}") do
              expect(page).to have_button('approve')
            end
          end
          
          it 'after pet is approved, their denial buttons are removed' do
            within("##{pet_app_1.pet_id}") do
              click_button('deny')
            end
            
            within("##{pet_app_1.pet_id}") do
              expect(page).to have_no_button('deny')
            end
            
            within("##{pet_app_2.pet_id}") do
              expect(page).to have_button('deny')
            end
          end
          
          it 'after pet is approved, there is approved indication' do
            within("##{pet_app_1.pet_id}") do
              expect(page).to have_no_content('Adoption approved')
            end
            
            within("##{pet_app_1.pet_id}") do
              click_button('approve')
            end

            within("##{pet_app_1.pet_id}") do
              expect(page).to have_content('Adoption approved')
            end
          end
          
          it 'after pet is denied, there is denied indication' do
            within("##{pet_app_1.pet_id}") do
              expect(page).to have_no_content('Adoption denied')
            end
            
            within("##{pet_app_1.pet_id}") do
              click_button('deny')
            end

            within("##{pet_app_1.pet_id}") do
              expect(page).to have_content('Adoption denied')
            end
          end

          it 'after approving all pets the application shows approved status' do
            within("##{pet_app_1.pet_id}") do
              click_button('approve')
            end

            within("##{pet_app_2.pet_id}") do
              click_button('approve')
            end

            within("##{pet_app_3.pet_id}") do
              click_button('approve')
            end

            expected = admin_application_path(application_1)
            expect(page).to have_current_path(expected)
            expect(page).to have_content("Application Status: Approved")
          end

          it 'after denying all pets the application shows denied status' do
            within("##{pet_app_1.pet_id}") do
              click_button('deny')
            end

            within("##{pet_app_2.pet_id}") do
              click_button('deny')
            end

            within("##{pet_app_3.pet_id}") do
              click_button('deny')
            end

            expected = admin_application_path(application_1)
            expect(page).to have_current_path(expected)
            expect(page).to have_content("Application Status: Denied")
          end

          it 'after denying any pets the application shows denied status' do
            within("##{pet_app_1.pet_id}") do
              click_button('approve')
            end

            within("##{pet_app_2.pet_id}") do
              click_button('approve')
            end

            within("##{pet_app_3.pet_id}") do
              click_button('deny')
            end

            expected = admin_application_path(application_1)
            expect(page).to have_current_path(expected)
            expect(page).to have_content("Application Status: Denied")
          end
        end
      end
    end
    
    describe 'when approve or deny pet on one application does not affect others' do
      before(:each) { 
                     visit admin_application_path(application_1)
                     
                     within("##{pet_app_1.pet_id}") do
                       click_button('approve')
                     end

                     within("##{pet_app_2.pet_id}") do
                       click_button('deny')
                     end

                     visit admin_application_path(application_2)
                    }
      context 'second application is pending' do
        describe 'view elements' do
          it 'shows pets on the application' do
            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_2.name)
            expect(page).to have_no_content(pet_3.name)
            expect(page).to have_content(pet_4.name)
          end
          
          it 'has buttons to approve each pet' do
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_button('approve')
            end

            within("##{pet_app_5.pet_id}") do
              expect(page).to have_button('approve')
            end

            within("##{pet_app_6.pet_id}") do
              expect(page).to have_button('approve')
            end
          end

          it 'has buttons to deny each pet' do
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_button('deny')
            end

            within("##{pet_app_5.pet_id}") do
              expect(page).to have_button('deny')
            end

            within("##{pet_app_6.pet_id}") do
              expect(page).to have_button('deny')
            end
          end
        end

        describe 'when interacts with page elements' do
          it 'returns back to application show page after approving pet' do
            expect(page).to have_current_path(admin_application_path(application_2))

            within("##{pet_app_4.pet_id}") do
              click_button('approve')

              expect(page).to have_current_path(admin_application_path(application_2))
            end
          end

          it 'returns back to application show page after rejecting pet' do
            expect(page).to have_current_path(admin_application_path(application_2))

            within("##{pet_app_4.pet_id}") do
              click_button('deny')

              expect(page).to have_current_path(admin_application_path(application_2))
            end
          end
          
          it 'after pet is approved, their approval buttons are removed' do
            within("##{pet_app_4.pet_id}") do
              click_button('approve')
            end
            
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_no_button('approve')
            end
            
            within("##{pet_app_5.pet_id}") do
              expect(page).to have_button('approve')
            end
          end

          it 'after pet is approved, their denial buttons are removed' do
            within("##{pet_app_4.pet_id}") do
              click_button('deny')
            end
            
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_no_button('deny')
            end
            
            within("##{pet_app_5.pet_id}") do
              expect(page).to have_button('deny')
            end
          end
          
          it 'after pet is approved, there is approved indication' do
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_no_content('Adoption approved')
            end

            within("##{pet_app_4.pet_id}") do
              click_button('approve')
            end
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_content('Adoption approved')
            end
          end

          it 'after pet is denied, there is denied indication' do
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_no_content('Adoption denied')
            end

            within("##{pet_app_4.pet_id}") do
              click_button('deny')
            end
            within("##{pet_app_4.pet_id}") do
              expect(page).to have_content('Adoption denied')
            end
          end
        end
      end
    end
  end
end