class CreateEngagements < ActiveRecord::Migration[5.1]
  def change
    create_table :engagements do |t|
      t.boolean :cio
      t.datetime :date
      t.text :notes
      t.references :engagement_type, foreign_key: true

      t.timestamps
    end
  end
end
