class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string  :place_name, null: false
      t.string  :address, null: false
      t.timestamps
    end
  end
end

