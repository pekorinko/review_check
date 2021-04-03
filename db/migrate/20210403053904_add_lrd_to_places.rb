class AddLrdToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :lrd, :string
    add_index :places, :lrd, unique: true
  end
end
