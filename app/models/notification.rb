class Notification < ApplicationRecord
  after_create_commit { broadcast_notification }
  after_update_commit { broadcast_notification }
  belongs_to :user

  validates :message, presence: true

  def mark_as_read
    self.is_read=true
    self.save
  end

  private

  def broadcast_notification()
    user=self.user
    count=user.unread_notification.count
    NotifyChannel.broadcast_to(user,count)
  end

end
