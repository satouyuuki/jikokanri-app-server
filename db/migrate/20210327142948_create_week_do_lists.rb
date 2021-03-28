class CreateWeekDoLists < ActiveRecord::Migration[6.1]
  def change
    create_table :week_do_lists do |t|
      t.references :week, foreign_key: true
      t.references :target_list, foreign_key: true
      t.integer :done_num
      t.timestamps
    end
  end
end
