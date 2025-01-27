class CreateForumes < ActiveRecord::Migration[8.0]
  def change
    create_table :forumes do |t|
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
