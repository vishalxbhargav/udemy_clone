class QuestionsController < ApplicationController
    layout "forume"
    before_action :authenticate_user!
    before_action :set_question,only: [:show]
    before_action :set_forume,only: [:index,:new,:create]
    def index
        @question
    end

    def new
        @question=@forume.questions.new
    end

    def show
        @question
    end

    def create
        @question=@forume.questions.new(question_params)
        if @question.save
            redirect_to forume_path(@forume)
        end
    end
    private
    
    def set_question
        @question=Question.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @question.nil?
    end

    def set_forume
        @forume=Forume.find_by(id: params[:forume_id])
        render file: "#{Rails.root}/public/course404.html" if @forume.nil?
    end
    
    def question_params
        params.expect(question: [:title,:description])
    end
end
