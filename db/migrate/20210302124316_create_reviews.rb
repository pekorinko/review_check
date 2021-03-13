class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
<<<<<<< HEAD
      t.string :text, null: true
      t.integer :count
      t.float :star
=======
      t.string  :text, null: false
      t.integer :count, null: false
      t.float :star, null: false
>>>>>>> 6e23f5216bd5a541ac1a577253f9d340480c43b4
      t.timestamps
    end
  end
end
