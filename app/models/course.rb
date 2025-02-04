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

    validates :thumbnail,presence: true, on: :create
    validates :category_id, presence: true, on: :create
    validates :title, presence: true,length: {minimum:10}, on: :create
    validates :title, length: { minimum: 10 }, on: :update
    validates :price, presence: true, on: :create


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

    def completion
        total_chapter_count = self.chapters.count
        completed_chapter_count = self.chapters.where(completed: true).count
      
        if total_chapter_count > 0
          (100.0 / total_chapter_count) * completed_chapter_count
        else
          0
        end
    end
      
end
