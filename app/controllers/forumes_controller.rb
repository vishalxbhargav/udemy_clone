class ForumesController < ApplicationController
    before_action :set_forume,only: [:show]
    layout "forume"
    def index
       @forume
    end
    
    def show

    end

    private 
    def set_forume
        @forume=Forume.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @forume.nil?
    end
end
