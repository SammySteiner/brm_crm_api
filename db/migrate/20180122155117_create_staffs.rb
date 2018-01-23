class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :cell_phone
      t.string :office_phone
      t.references :role, foreign_key: true
      t.references :agency, foreign_key: true

      t.timestamps
    end
  end
end
