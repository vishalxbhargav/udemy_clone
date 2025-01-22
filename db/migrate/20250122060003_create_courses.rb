class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
