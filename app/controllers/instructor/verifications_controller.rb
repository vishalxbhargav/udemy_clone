class Instructor::VerificationsController < ApplicationController
    before_action :set_course,only:[:verification]
    before_action :authenticate_user!

    def verification
        debugger
        @verification=Verifycation.new(course_id: @course.id)
        if @verification.save
            redirect_to instructor_course_path(@course),notice: "successfully send for verification"
        else
            redirect_to instructor_course_path(@course),notice: "something went wrong"
        end
    end

    private

    def set_course
        @course=Course.find_by(id: params[:course_id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
