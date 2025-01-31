module NotificationsHelper
    def read_all(notifications)
        notifications.each do |notification|
            notification.mark_as_read
        end
        true
    end
end
