class Instructor::ChaptersController < ApplicationController
    load_and_authorize_resource only: [:create,:show,:edit,:update,:destroy]
    layout "instructor"
    before_action :authenticate_user!
    before_action :set_course, only: [ :new, :create,:destroy ]
    before_action :set_chapter, only: [ :show,:edit,:update,:destroy]
    def new
        @chapter=@course.chapters.new
    end

    def create
        @chapter=@course.chapters.new(chapter_params)
        if @chapter.save
            SendChapterAddedNotificationJob.perform_later(@chapter)
            redirect_to instructor_course_path(@course)
        else
            redirect_to new_instructor_course_chapter_path,notice:@chapter.errors
        end
    end

    def update
        if @chapter.update(chapter_params)
            redirect_to instructor_course_path(@chapter),notice:"Course updated successfully"
        else
            redirect_to edit_instructor_chapter_path(@chapter),notice: @chapter.errors
        end
    end

    def show
        @chapter
    end

    def get_chapter
        @chapter = Chapter.find_by(id: params[:id])
        
        if @chapter
          render partial: "components/chapter_content", locals: { chapter: @chapter }
        else
          render plain: "Chapter not found", status: :not_found
        end
      end
    def edit
        @chapter
    end

    def destroy
        debugger
        if @chapter.destroy
            redirect_to instructor_course_path(@course),notice:"Chapter deleted successfully" 
        else
            redirect_to edit_instructor_chapter_path(@chapter),notice: @course.errors
        end
    end

    private

    def chapter_params
        params.require(:chapter).permit( :title, :video, docs: [] )
    end

    def set_chapter
        @chapter=Chapter.find_by(id: params[:id])
        if @chapter.nil?
            render file: "#{Rails.root}/public/course404.html",status:404 
        else
            check_instructor(@chapter.course)
        end
        render file: "#{Rails.root}/public/chapter404.html" if @chapter.nil?
    end

    def check_instructor(course)
        if course&.user!=current_user
            render plain: "unauthorized access",status:401
        end
    end

    def set_course
        debugger
        @course=Course.find_by(id: params[:course_id])
        
        if @course.nil?
            render file: "#{Rails.root}/public/course404.html",status:404 
        else
            check_instructor(@course)
        end
    end
end
