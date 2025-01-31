class NotificationsController < ApplicationController
    include NotificationsHelper
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index
        @notifications=current_user.unread_notification
    end
    def all_read
        @notifications=current_user.unread_notification
        if read_all(@notifications)
            render plain: "all notification read", status: 200
        else
            render plain: "something went wrong",status: 500
        end
    end
end
