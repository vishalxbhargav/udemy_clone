class Instructor::ChaptersController < ApplicationController
    layout "instructor"
    before_action :authenticate_user!
    before_action :set_course, only: [ :new, :create ]

    def new
        @chapter=@course.chapters.new
    end

    def create
        debugger
        @chapter=@course.chapters.new(chapter_params)
        if @chapter.save
            redirect_to instructor_course_path(@course)
        else
        end
    end

    private

    def chapter_params
        params.require(:chapter).permit( :title, :video, docs: [] )
    end

    def set_chapter
        @course=Course.find_by(id: params[:id])
        render file: "#{Rails.root}/public/chapter404.html" if @chapter.nil?
    end

    def set_course
        @course=Course.find_by(id: params[:course_id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
