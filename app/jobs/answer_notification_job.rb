class AnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    comment=args[0]
    Notification.create(message:"#{comment.user.full_name}, comment on your answer : #{comment.answer.body[0,20]}",user_id:comment.answer.user_id)
  end
end
