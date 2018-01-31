class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.text :description
      t.text :notes
      t.boolean :escalation
      t.integer :priority
      t.boolean :actionable
      t.string :ksr
      t.boolean :key_project
      t.references :agency
      t.references :service
      t.references :engagement, foreign_key: true
      t.integer :created_by_id
      t.datetime :start_time
      t.datetime :last_modified_on
      t.integer :last_modified_by_id
      t.datetime :resolved_on
      t.text :resolution_notes

      t.timestamps
    end
  end
end
