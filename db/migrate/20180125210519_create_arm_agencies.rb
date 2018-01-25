class CreateArmAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :arm_agencies do |t|
      t.integer :arm_id
      t.references :agency

      t.timestamps
    end
  end
end
