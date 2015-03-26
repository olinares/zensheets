class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :user_id
      t.string :url
      t.string :name

      t.timestamps null: false
    end
  end
end
