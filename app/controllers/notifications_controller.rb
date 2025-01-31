class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @notifications=current_user.unread_notification
    end
    def all_read
        @notifications=current_user.unread_notificaiton
    end
end
