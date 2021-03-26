class AddYearToMonths < ActiveRecord::Migration[6.1]
  def change
    add_column :months, :year, :integer
    add_index  :months, [:year, :month], unique: true
  end
end
