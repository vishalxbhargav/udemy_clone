class Course < ApplicationRecord
    belongs_to :user,class_name: "User",foreign_key: "instructor_id"
    belongs_to :category
    has_rich_text :course_content
    has_one_attached :thumbnail
    has_many :chapters,dependent: :destroy
    has_many :enrollments
    has_many :enrolled_users, through: :enrollments,source: :user

    validates :thumbnail,presence: true, on: :create
    validates :category_id, presence: true, on: :create
    validates :title, presence: true,length: {minimum:10}, on: :create
    validates :title, length: { minimum: 10 }, on: :update
    validates :price, presence: true, on: :create
end
