class AddUserIdToMonths < ActiveRecord::Migration[6.1]
  def change
    add_column :months, :user_id, :integer
    add_reference :months, :user, foreign_key: true
  end
end
