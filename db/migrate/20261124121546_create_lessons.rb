class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :content
      t.integer :position, null: false
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
