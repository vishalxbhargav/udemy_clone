class Enrollment < ApplicationRecord
    belongs_to :user
    belongs_to :course
    has_many :progres

    validate :is_enrolled

    enum :status,[ :enrolled, :complete, :cencelled]
    scope :enrollment?, ->(course,user) { exists?([course_id:course.id,user_id: user.id])}

    
    def get_completed_chapter
        Progre.where(enrollment_id: self.id).where(completed:true).count
    end
    private

    def is_enrolled
        if Enrollment.exists?([course_id:self.course_id,user_id: self.user_id])
            errors.add(:user_id, "already enrolled")
        end
    end   
end
