class CreateTargetLists < ActiveRecord::Migration[6.1]
  def change
    create_table :target_lists do |t|
      t.string :target_text
      t.integer :target_num
      t.references :month, foreign_key: true
      t.timestamps
    end
  end
end
