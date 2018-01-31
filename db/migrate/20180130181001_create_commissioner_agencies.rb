class CreateCommissionerAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :commissioner_agencies do |t|
      t.integer :commissioner_id
      t.references :agency

      t.timestamps
    end
  end
end
