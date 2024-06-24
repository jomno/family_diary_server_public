class AddColsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile, :string
    add_column :users, :printer_email, :string
  end
end
