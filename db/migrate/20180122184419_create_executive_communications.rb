class CreateExecutiveCommunications < ActiveRecord::Migration[5.1]
  def change
    create_table :executive_communications do |t|
      t.string :subject
      t.text :content
      t.datetime :time

      t.timestamps
    end
  end
end
