class CreateStaffEngagements < ActiveRecord::Migration[5.1]
  def change
    create_table :staff_engagements do |t|
      t.references :staff, foreign_key: true
      t.references :engagement, foreign_key: true

      t.timestamps
    end
  end
end
