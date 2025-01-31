class Notification < ApplicationRecord
  belongs_to :user

  def mark_as_read
    self.is_read=true
    self.save
  end

end
