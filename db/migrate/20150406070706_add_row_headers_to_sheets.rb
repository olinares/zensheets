class AddRowHeadersToSheets < ActiveRecord::Migration
  def change
    add_column :sheets, :headers, :text, default: '', null: false
    add_column :sheets, :rows, :text, default: '', null: false
  end
end
