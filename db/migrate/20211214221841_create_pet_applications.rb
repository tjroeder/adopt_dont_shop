class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet, foreign_key: true
      t.references :application, foreign_key: true
      t.integer :app_approval, default: 'undecided'

      t.timestamps
    end
  end
end
