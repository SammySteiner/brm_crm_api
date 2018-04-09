class CreateAgencyServices < ActiveRecord::Migration[5.1]
  def change
    create_table :agency_services do |t|
      t.references :agency
      t.references :service

      t.timestamps
    end
  end
end
