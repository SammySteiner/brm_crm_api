class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.integer :sla
      t.integer :sdl_id
      t.integer :service_owner_id
      t.boolean :core
      t.references :division
      t.references :service_category

      t.timestamps
    end
  end
end
