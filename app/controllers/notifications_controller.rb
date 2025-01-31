class NotificationsController < ApplicationController
    include NotificationsHelper
    before_action :authenticate_user!
    def index
        @notifications=current_user.unread_notification
    end
    def all_read
        @notifications=current_user.unread_notification
        if read_all(@notifications)
            redirect_to root_path
        else
            render plain: "something went wrong",status: 500
        end
    end
end
