class CreateIdentifies < ActiveRecord::Migration[7.1]
  def change
    create_table :identifies do |t|
      t.references :user, foreign_key: true
      t.text :response
      t.string :access_token
      t.string :uid

      t.timestamps
    end
    add_index :identifies, :uid
  end
end
