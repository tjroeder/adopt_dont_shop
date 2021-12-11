require 'rails_helper'

RSpec.describe Application, type: :model do
  let!(:application_1) { Application.create!(name: 'Tim', street_address: '123 Taco Lane', city: 'Fort', state: 'CO', zip_code: '12345') }
  let!(:application_2) { Application.create!(name: 'Sue', street_address: '321 Burrito Lane', city: 'Boulder', state: 'UT', zip_code: '54321') }
  let!(:application_3) { Application.create!(name: 'Case', street_address: '4231 Chili Lane', city: 'Denver', state: 'NY', zip_code: '33333') }

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
  end

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
  end
end