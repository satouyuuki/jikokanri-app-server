class DeleteYearIdUniqIndexFromMonths < ActiveRecord::Migration[6.1]
  def change
    remove_index :months, [:year, :month]
  end
end
