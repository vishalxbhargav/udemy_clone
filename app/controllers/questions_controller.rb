class QuestionsController < ApplicationController
    layout "forume"
    before_action :authenticate_user!
    before_action :set_course,only: [:index,:create]
    before_action :set_question,only: [:index,:create]
    def index
        @question
    end

    def new
        debugger
        @question=Question.new
    end
    
    def create
        debugger
        @question=@course.forume.question(question_params)
        if @question.save
            render partial: "componentes/question",question: @question
        end
    end
    private
    
    def set_question
        @question=Question.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @question.nil?
    end

    def set_course
        @course=Course.find_by(id: params[:course_id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
    
    def question_params
        debugger
        params.expact(question: [:title,:description])
    end
end
