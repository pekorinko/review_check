class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string  :text, null: false
      t.integer :count, null: false
      t.float :star, null: false
      t.timestamps
    end
  end
end
