class AnswersController < ApplicationController
    layout "forume"
    before_action :set_question,only: [:new,:create]
    before_action :set_answer,only: [:show]

    def new
        @answer=@question.answers.new
    end

    def show
        @answer
    end

    def create
        @answer=@question.answers.new(answer_params)
        if @answer.save
            redirect_to question_path(@question)
        end
    end

    private
    def set_answer
        @answer=Answer.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @answer.nil?
    end

    def set_question
        @question=Question.find_by(id: params[:question_id])
        render file: "#{Rails.root}/public/course404.html" if @question.nil?
    end

    def answer_params
        params.expect(answer: [:content])
    end

end
