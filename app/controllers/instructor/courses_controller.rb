class Instructor::CoursesController < ApplicationController
    before_action :set_course, only: [ :show, :edit, :update, :destroy]
    before_action :authenticate_user!
    layout "instructor"
    def index

    end

    def new
        @course=current_user.courses.build
    end
    
    def show
        @course
    end
    
    def edit
        @course
    end

    def update
        if @course.update(course_params)
            redirect_to instructor_path,notice:"Course updated successfully"
        else
            redirect_to new_instructor_course_path(@course),notice: @course.errors
        end
    end

    def create
        @course=current_user.courses.build(course_params)
        if @course.save
            Forume.create(course_id:@course.id)
            redirect_to instructor_path,notice:"Course created successfully"
        else
            redirect_to new_instructor_course_path(@course),notice: @course.errors
        end
    end
    
    def destroy
        if @course.destroy
            redirect_to instructor_path,notice:"Course deleted successfully" 
        else
            redirect_to new_instructor_course_path(@course),notice: @course.errors
        end
    end

    private
    
    def set_course
        @course=Course.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end

    def course_params
        params.require(:course).permit( :title, :description, :course_content,:price,:thumbnail, :category_id)
    end

end
