class User < ApplicationRecord
  has_many :courses, class_name:"Course", foreign_key: "instructor_id"
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments,source: :course
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name,presence: true, on: :create
  validates :username, presence: true, on: :create
  validates :email,presence: true, uniqueness: true, format: Devise.email_regexp,on: :create
  enum :role,[:User,:Instructor]

  def full_name
    self.first_name+" "+self.last_name
  end
end
