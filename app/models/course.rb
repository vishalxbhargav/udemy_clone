class Course < ApplicationRecord
    belongs_to :user,class_name: "User",foreign_key: "instructor_id"
    belongs_to :category
    has_rich_text :course_content
    has_one_attached :thumbnail
    has_many :chapters,dependent: :destroy
end
