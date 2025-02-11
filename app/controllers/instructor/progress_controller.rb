class Instructor::ProgressController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def mark_as_complete
        @chapter = Chapter.find_by(id: params[:chapter_id])
        @enrollment=current_user.enrollments.where(course_id:@chapter.course.id)[0]
        @progres=Progre.where(enrollment_id:@enrollment.id,chapter_id:@chapter.id)[0]
        @progres.completed=!@progres.completed
        if @progres.save
            render plain: "Status Change", status: :ok
        else 
            render plain: "Chapter not found", status: :not_found
        end
    end
end
