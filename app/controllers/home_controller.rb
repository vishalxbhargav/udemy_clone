class HomeController < ApplicationController
    def index
    end
    
    def search
        @courses=search_result
    end

    private 

    def search_result
        title=Course.arel_table[:title]
        @courses=Course.where(title.matches("%#{params[:query]}%"))
    end
end