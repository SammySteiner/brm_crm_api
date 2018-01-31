class CreateCioAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :cio_agencies do |t|
      t.integer :cio_id
      t.references :agency

      t.timestamps
    end
  end
end
