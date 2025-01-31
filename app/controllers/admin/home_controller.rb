class Admin::HomeController < ApplicationController
    layout "admin"
    before_action :authenticate_user!
    before_action :is_admin

    def index
    
    end

    private
    def is_admin
        render plain: "Your are not authorized person" unless current_user.Admin?
    end
end
