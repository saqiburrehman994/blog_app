class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.date :birth_date
      t.integer :gender

      t.timestamps
    end
  end
end
