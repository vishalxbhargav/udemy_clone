class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.integer :status
      t.belongs_to :user
      t.belongs_to :course
      t.timestamps
    end
  end
end
