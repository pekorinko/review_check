class Dummy < ActiveRecord::Migration[6.1]
  def change
    add_reference :results, :user, foreign_key: true
  end
end
