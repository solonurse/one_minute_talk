class CreateReminders < ActiveRecord::Migration[7.1]
  def change
    create_table :reminders do |t|
      t.boolean :reminder, null: false, default: false
      t.datetime :start_time, null: false
      t.references :user, null: false, foreign_key: true
      t.references :memo, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reminders, [:user_id, :memo_id], unique: :true
  end
end
