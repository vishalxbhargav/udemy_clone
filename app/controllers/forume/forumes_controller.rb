class Forume::ForumesController < ApplicationController
    load_and_authorize_resource
    layout "forume"
    layout "student",only:[:index]
    before_action :authenticate_user!
    before_action :set_forume,only:[:show]
    include ForumeList

    def index
        student_forume
    end 

    def show
        @forume
    end

    private

    def set_forume
        @forume=Forume.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @forume.nil?
    end
end