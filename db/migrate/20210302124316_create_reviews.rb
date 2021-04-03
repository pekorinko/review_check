class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :text, null: false
      t.integer :count, null: false
      t.float :star, null: false
      t.references :place, index: true, foreign_key: true
      t.timestamps
    end
  end
end
