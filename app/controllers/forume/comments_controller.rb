class Forume::CommentsController < ApplicationController
    layout "forume"
    before_action :set_answer, only: [:create]
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def create
        @comment=@answer.comments.new(comment_params)
        @comment.user_id=current_user.id
        if @comment.save
            redirect_to forume_answer_path(@answer),notice:"Comment successfully created"
        else
            redirect_to forume_answer_path(@answer),notice:@comment.errors
        end
    end

    private
    
    def set_answer
        @answer=Answer.find_by(id: params[:answer_id]);
        render file: "#{Rails.root}/public/course404.html" if @answer.nil?
    end
    
    def comment_params
        params.require(:comment).permit([:body])
    end
end
