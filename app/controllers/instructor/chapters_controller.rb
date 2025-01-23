class Instructor::ChaptersController < ApplicationController
    layout "instructor"
    before_action :authenticate_user!
    before_action :set_course, only: [ :new, :create,:destroy ]
    before_action :set_chapter, only: [ :show,:edit,:update,:destroy ]
    def new
        @chapter=@course.chapters.new
    end

    def create
        @chapter=@course.chapters.new(chapter_params)
        if @chapter.save
            redirect_to instructor_course_path(@course)
        else
        end
    end

    def update
        debugger
        if @chapter.update(chapter_params)
            redirect_to instructor_course_path(@chapter),notice:"Course updated successfully"
        else
            redirect_to edit_instructor_chapter_path(@course),notice: @course.errors
        end
    end

    def show
        @chapter
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
        render file: "#{Rails.root}/public/chapter404.html" if @chapter.nil?
    end

    def set_course
        @course=Course.find_by(id: params[:course_id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
