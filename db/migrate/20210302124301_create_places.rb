class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string  :place_name
      t.string  :address
      t.timestamps
    end
  end
end

