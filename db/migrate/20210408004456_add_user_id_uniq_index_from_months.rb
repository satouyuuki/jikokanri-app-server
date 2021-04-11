class AddUserIdUniqIndexFromMonths < ActiveRecord::Migration[6.1]
  def change
    add_index  :months, [:year, :month, :user_id], unique: true
  end
end
