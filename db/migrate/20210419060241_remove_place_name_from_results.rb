class RemovePlaceNameFromResults < ActiveRecord::Migration[6.1]
  def change
    remove_column :results, :place_name, :text
  end
end
