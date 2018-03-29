class CreateConnectionEngagements < ActiveRecord::Migration[5.1]
  def change
    create_table :connection_engagements do |t|
      t.references :connection
      t.references :engagement

      t.timestamps
    end
  end
end
