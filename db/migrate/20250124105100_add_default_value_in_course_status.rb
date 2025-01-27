class AddDefaultValueInCourseStatus < ActiveRecord::Migration[8.0]
  def change
    change_column :enrollments, :status, :integer, default: 0
  end
end
