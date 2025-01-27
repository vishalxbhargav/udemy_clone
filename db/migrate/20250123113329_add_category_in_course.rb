class AddCategoryInCourse < ActiveRecord::Migration[8.0]
  def change
    add_reference :courses, :category, foreign_key: true
  end
end
