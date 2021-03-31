class AddUniqueKeyToWeekDoneLists < ActiveRecord::Migration[6.1]
  def change
    add_index :week_done_lists, [:week_id, :target_list_id], unique: true
  end
end
