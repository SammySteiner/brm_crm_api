class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.datetime :date
      t.text :notes
      t.references :connection_type

      t.timestamps
    end
  end
end
