class ChangeWeekDoListsToWeekDoneLists < ActiveRecord::Migration[6.1]
  def change
    rename_table :week_do_lists, :week_done_lists
  end
end
