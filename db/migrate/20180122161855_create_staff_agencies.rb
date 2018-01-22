class CreateStaffAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :staff_agencies do |t|
      t.references :staff, foreign_key: true
      t.references :agency, foreign_key: true

      t.timestamps
    end
  end
end
