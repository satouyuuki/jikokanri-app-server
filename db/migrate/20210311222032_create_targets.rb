class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.integer :total_time
      t.string :achieved_text
      t.timestamps
    end
  end
end
