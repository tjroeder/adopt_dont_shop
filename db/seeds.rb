PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: true, rank: 6)
shelter_3 = Shelter.create!(name: 'Animal House', city: 'Fort Collins, CO', foster_program: false, rank: 9)

pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
pet_2 = shelter_3.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
pet_3 = shelter_3.pets.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven')
pet_4 = shelter_2.pets.create!(adoptable: false, age: 5, breed: 'dachshund', name: 'Woodrow')

application_1 = Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345')
application_2 =  Application.create!(name: 'Sue', street_address: '321 Burrito Lane', city: 'Boulder', state: 'UT', zip_code: '54321')
application_3 =  Application.create!(name: 'Case', street_address: '4231 Chili Lane', city: 'Denver', state: 'NY', zip_code: '33333')

PetApplication.create!(pet: pet_1, application: application_1)
PetApplication.create!(pet: pet_2, application: application_1)
PetApplication.create!(pet: pet_3, application: application_1)

PetApplication.create!(pet: pet_2, application: application_2)
PetApplication.create!(pet: pet_4, application: application_2)