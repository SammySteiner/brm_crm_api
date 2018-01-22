class CreateEngagementTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :engagement_types do |t|
      t.string :medium

      t.timestamps
    end
  end
end
