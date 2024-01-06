class CreateExplanations < ActiveRecord::Migration[7.1]
  def change
    create_table :explanations do |t|
      t.string :element, null:false
      t.string :basis, null:false
      t.references :memo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
