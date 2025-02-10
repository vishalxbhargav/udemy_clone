class Forume::QuestionsController < ApplicationController
    layout "forume"
    before_action :set_question,only:[:show,:edit,:update,:destroy]
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def show
        @question
    end

    def edit
        @question
    end

    def update
        debugger
        if @question.update(question_params)
            redirect_to forume_forume_path(@question.forume)
        else
            redirect_to forume_forume_path(@question.forume),notice:@question.errors
        end
    end

    def create
        @question=Question.new(question_params)
        @question.user_id=current_user.id
        @question.forume_id=params[:forume_id]
        if @question.save
            ForumeNotificationJob.perform_later(@question)
            render partial: "components/question", locals:{question: @question}
        else
            render plain: "Error founded", status: :not_found
        end
    end

    def destroy
        if @question.destroy
            redirect_to forume_forume_path(@question.forume),notice:"Question Successfully deleted"
        else
            redirect_to forume_forume_path(@question.forume),notice:@question.errors
        end
    end

    private

    def set_question
        @question=Question.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @question.nil?
    end

    def question_params
        params.require(:question).permit(:title,:description,:user_id)
    end
end
