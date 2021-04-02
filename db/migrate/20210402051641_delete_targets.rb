class DeleteTargets < ActiveRecord::Migration[6.1]
  def change
    drop_table :targets
  end
end
