class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :content, null: false
      t.boolean :privacy, default: false

      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
