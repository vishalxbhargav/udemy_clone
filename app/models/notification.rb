class Notification < ApplicationRecord
  after_commit :broadcast_notification, on: :create
  belongs_to :user

  def mark_as_read
    self.is_read=true
    self.save
  end

  private

  def broadcast_notification
    ActionCable.server.broadcast("notify_channel", self)
  end

end
