class AddInstructorReferenceInCourse < ActiveRecord::Migration[8.0]
  def change
    add_reference :courses, :instructor, foreign_key: {to_table: :users}
  end
end
