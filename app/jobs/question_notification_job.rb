class QuestionNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    answer=args[0]
    Notification.create!(message:"#{answer.user.full_name} reply your question : #{answer.question.title[0,20]}",user_id:answer.question.user_id)
  end
end
