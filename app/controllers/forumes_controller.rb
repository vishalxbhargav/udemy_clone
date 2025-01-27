class ForumesController < ApplicationController
    before_action :set_course,only: [:index]
    layout "forume"
    def index

    end

    private 

    def set_course
        @course=Course.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
