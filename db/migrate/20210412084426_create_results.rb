class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.text :place_name
      t.text :address
      t.float :star_ave
      t.integer :count_ave
      t.integer :text_ave
      t.float :credible_star_ave

      t.timestamps
    end
  end
end
