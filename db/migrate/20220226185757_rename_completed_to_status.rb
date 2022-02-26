class RenameCompletedToStatus < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :completed, :status
  end
end
