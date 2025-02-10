class Forume::AnswersController < ApplicationController
    layout "forume"
    before_action :set_answer, only: [:show,:edit,:update,:destroy]
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def show
        @answer
    end
    
    def edit
        @answer
    end

    def create
        @answer=Answer.new(answer_params)
        @answer.user_id=current_user.id
        @answer.question_id=params[:question_id]
        if @answer.save
            QuestionNotificationJob.perform_later(@answer)
            render partial: "components/answer", locals:{answer: @answer}
        else
            render plain: "Error founded", status: :not_found
        end
    end

    def update
        if @answer.update(answer_params)
            redirect_to forume_question_path(@answer.question)
        else
            redirect_to edit_forume_answer_path(@answer)
        end
    end

    def destroy
        if @answer.destroy
            redirect_to forume_question_path(@answer.question),notice:"Successfully Answer Deleted"
        else
            redirect_to forume_question_path(@answer.question),notice:"Something went wrong"
        end
    end
    private

    def set_answer
        @answer=Answer.find_by(id: params[:id]);
        render file: "#{Rails.root}/public/course404.html" if @answer.nil?
    end

    def answer_params
        params.require(:answer).permit(:body)    
    end
end
