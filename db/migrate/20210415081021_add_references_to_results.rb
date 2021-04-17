class AddReferencesToResults < ActiveRecord::Migration[6.1]
  def change
    add_reference :results, :place, index: true, foreign_key: true
  end
end
