class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string  :text
      t.integer :count
      t.float :star
      t.timestamps
    end
  end
end
