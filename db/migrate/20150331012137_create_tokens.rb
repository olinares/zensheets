class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :user_id, null: false
      t.string :access_token, null: false
      t.string :refresh_token, null: false
      t.datetime :expires_at, null: false

      t.timestamps null: false
    end
  end
end
