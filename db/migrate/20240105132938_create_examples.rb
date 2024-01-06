class CreateExamples < ActiveRecord::Migration[7.1]
  def change
    create_table :examples do |t|
      t.string :sentence
      t.references :memo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
