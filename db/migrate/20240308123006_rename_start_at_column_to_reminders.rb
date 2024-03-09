class RenameStartAtColumnToReminders < ActiveRecord::Migration[7.1]
  def change
    rename_column :reminders, :start_at, :start_time
  end
end
