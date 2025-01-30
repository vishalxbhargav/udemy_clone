class Student::EnrollmentController < ApplicationController
    layout "student", except: [:course]

    before_action :set_course,only: [:course,:enrolled, :enrolled_course]
    def course
        @course
    end
    
    def enrolled
        @enrollment=current_user.enrollments.new(course_id: @course.id)
        if @enrollment.save
            redirect_to student_my_learning_path,notice: "successfully enrolled in course"
        else
            redirect_to student_path(@course),notice: @enrollment.errors[:user_id][0]
        end
    end

    def my_learning
        @courses=current_user.enrolled_courses
    end

    def transaction_history
        @orders=current_user.orders
    end

    def dashboard
    end

    def enrolled_course
        if current_user.enrolled_courses.any? @course
            @course
            render layout: "content"
        else
            redirect_to root_path,notice: "Student not enrolled for this course"
        end
    end
    private

    def set_course
        @course=Course.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
