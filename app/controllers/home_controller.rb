class HomeController < ApplicationController
    def index
    end
    
    def search
        @courses=search_result
    end

    private 

    def search_result
        query=params[:query]
        query.strip
        Course.where("title LIKE ?","%"+query + "%") unless query.empty?
    end
end