class AddColumnToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :star_ave, :integer
  end
end
