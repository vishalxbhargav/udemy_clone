class ForumeNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    question=args[0]
    Notification.create(message:"#{question.user.full_name} post a question",user_id:question.forume.course.instructor_id)
  end
end
