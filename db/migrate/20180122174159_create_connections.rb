class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.datetime :date
      t.string :report
      t.text :notes
      t.integer :arm_id
      t.references :agency
      t.references :connection_type

      t.timestamps
    end
  end
end
