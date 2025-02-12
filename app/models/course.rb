class Course < ApplicationRecord
    belongs_to :user,class_name: "User",foreign_key: "instructor_id"
    belongs_to :category
    has_rich_text :course_content
    has_one_attached :thumbnail
    has_many :chapters,dependent: :destroy
    has_many :enrollments
    has_many :enrolled_users, through: :enrollments,source: :user
    has_many :orders
    has_one :forume
    has_one :verifycation

    validates :thumbnail,presence: true, on: :create
    validates :category_id, presence: true, on: :create
    validates :title, presence: true,length: {minimum:10}, on: :create
    validates :title, length: { minimum: 10 }, on: :update
    validates :price, presence: true, on: :create
    validates :thumbnail, content_type: ['image/png', 'image/jpeg']


    scope :last_month, -> {where('created_at >= ?',1.month.ago.beginning_of_month).where('created_at <= ?',1.month.ago.end_of_month)}

    def total_earning_by_course
      total_amout=0;
      self.orders.each do |order|
        total_amout= total_amout+order.amount.to_i;
      end
      return total_amout
    end

    def last_month_earning_by_course
      total_amout=0;
      self.orders.last_month.each do |order|
        total_amout= total_amout+order.amount.to_i;
      end
      return total_amout
    end

    def completion(user)
      chapter_count=self.chapters.count
      if chapter_count > 0
        enrollment=Enrollment.where(course_id: self.id,user_id:user.id)[0]
        return result=(100/self.chapters.count)* enrollment.get_completed_chapter
      end
      0
    end
      
end
