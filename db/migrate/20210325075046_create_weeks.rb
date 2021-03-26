class CreateWeeks < ActiveRecord::Migration[6.1]
  def change
    create_table :weeks do |t|
      t.integer :week
      t.references :month, foreign_key: true
      
      t.timestamps
    end
  end
end
