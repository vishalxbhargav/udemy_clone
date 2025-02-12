require 'rails_helper'

RSpec.describe Notification, type: :model do
  it{should belong_to(:user)}
  it{should validate_presence_of(:message)}

  describe "custom methode " do
    let(:user){FactoryBot.create(:user)}
    it "mark as complete" do
      notification=user.notifications.create(message:"tesig")
      expect(notification.mark_as_read).to eq(true)
    end
  end
end
