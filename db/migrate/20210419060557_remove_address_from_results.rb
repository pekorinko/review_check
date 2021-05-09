class RemoveAddressFromResults < ActiveRecord::Migration[6.1]
  def change
    remove_column :results, :address, :text
  end
end
