class CreateStaffConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :staff_connections do |t|
      t.references :staff, foreign_key: true
      t.references :connection, foreign_key: true

      t.timestamps
    end
  end
end
