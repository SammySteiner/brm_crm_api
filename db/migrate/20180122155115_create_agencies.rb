class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :acronym
      t.integer :category
      t.boolean :mayoral
      t.boolean :citynet

      t.timestamps
    end
  end
end
