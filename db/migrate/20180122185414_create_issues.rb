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
      t.references :agency, foreign_key: true
      t.references :service, foreign_key: true
      t.references :engagement, foreign_key: true
      t.integer :created_by
      t.datetime :start_time
      t.datetime :last_modified_on
      t.integer :last_modified_by
      t.datetime, :resolved_on
      t.text :resolution_notes

      t.timestamps
    end
  end
end
