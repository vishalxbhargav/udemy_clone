class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.belongs_to :course
      t.timestamps
    end
  end
end
