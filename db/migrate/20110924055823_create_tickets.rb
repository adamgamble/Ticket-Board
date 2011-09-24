class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :project_id
      t.string :title
      t.text :description
      t.string :state

      t.timestamps
    end
  end
end
