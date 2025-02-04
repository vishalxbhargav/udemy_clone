class CreateProgres < ActiveRecord::Migration[8.0]
  def change
    create_table :progres do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.references :chapter, null: false, foreign_key: true
      t.boolean :completed,default: false
      t.timestamps
    end
  end
end
