class SendChapterAddedNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chapter=args[0]
    course=chapter.course
    enrolled_users=course.enrolled_users
    if enrolled_users.any?
      enrolled_users.each do |user|
        user.notifications.create(message:"new chapter added in your enrolled course #{course.title}")
      end
    else
      return
    end
  end
end
