class Chapter < ApplicationRecord
    belongs_to :course
    has_one_attached :video
    has_many_attached :docs

    validates :docs, attached:true, content_type: [:pdf]
    validates :video, attached:true, content_type: [:mkv,:mp4,:avi,:mov]

   def get_progres(user)
        @enrollment=user.enrollments.where(course_id: self.course.id)[0]
        @progres=Progre.where(enrollment_id:@enrollment.id,chapter_id:self.id)[0]
   end
end
