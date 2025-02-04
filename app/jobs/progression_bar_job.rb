class ProgressionBarJob < ApplicationJob
  queue_as :default

  def perform(*args)
    enrollment=args[0]
    course=args[1]
    course.chapters.ids.each do |chapter_id|
      Progre.create(enrollment_id:enrollment.id,chapter_id:chapter_id)
    end
    return
  end
end
