class Admin::UsersController < ApplicationController
    before_action :set_user,only:[:show,:edit,:update,:destroy]
    layout "admin"


    def index
        @users=User.all
    end
    
    def show
        @user
    end

    def edit
        @user
    end

    def update
        if @user.update(user_params)
            redirect_to admin_users_path,notice:"user successfully updated"
        else
            redirect_to edit_admin_user(@user),notice:@user.errors[0]
        end
    end

    def destroy
        if @user.destroy
            redirect_to admin_users_path,notice:"user successfully deleted"
        end
    end

    private 

    def set_user
        @user=User.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @user.nil?
    end

    def user_params
        params.require(:user).permit( :first_name, :last_name, :email,:username,:role)
    end

end
