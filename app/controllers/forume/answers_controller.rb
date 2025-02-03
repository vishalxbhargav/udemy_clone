class Forume::AnswersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def create
        @answer=Answer.new(answer_params)
        @answer.user_id=current_user.id
        @answer.question_id=params[:question_id]
        if @answer.save
            render partial: "components/answer", locals:{answer: @answer}
        else
            render plain: "Error founded", status: :not_found
        end
    end

    private

    def answer_params
        params.require(:answer).permit(:body)    
    end
end
