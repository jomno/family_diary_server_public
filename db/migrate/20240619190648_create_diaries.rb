class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true
      t.date :released_date, null: false
      t.text :content
      t.string :image
      t.string :audio_url
      t.string :pdf_url

      t.timestamps
    end
  end
end
