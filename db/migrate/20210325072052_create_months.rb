class CreateMonths < ActiveRecord::Migration[6.1]
  def change
    create_table :months do |t|
      t.integer :month

      t.timestamps
    end
  end
end
