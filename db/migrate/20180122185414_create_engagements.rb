class CreateEngagements < ActiveRecord::Migration[5.1]
  def change
    create_table :engagements do |t|
      t.string :title
      t.text :report
      t.text :notes
      t.string :ksr
      t.string :inc
      t.string :prj
      t.integer :priority
      t.references :service
      t.references :connection, foreign_key: true
      t.references :engagement_type, foreign_key: true
      t.integer :created_by_id
      t.datetime :start_time
      t.datetime :last_modified_on
      t.integer :last_modified_by_id, default: nil
      t.datetime :resolved_on

      t.timestamps
    end
  end
end
